module LambdaSystemF.Eval
(
    eval,
)
where

import LambdaSystemF.Data.Exp
import Shared.Data.Env

eval_with_env :: Exp -> Env Exp -> Exp

eval_with_env v env | is_normal_form v = v

-- if-true
-- if-false
eval_with_env (IfElse exp1 exp2 exp3) env = case cond of
                                                 ExpTrue  -> eval_with_env exp2 env
                                                 ExpFalse -> eval_with_env exp3 env
    where cond = eval_with_env exp1 env

eval_with_env (Var string) env = val
    where val = env_unsafe_read env string

-- NB: eval App AbsClosure returns original context, the new_context is only used within body of app (exp2)
-- application Closure
eval_with_env call@(App (AbsClosure string _ body absenv) exp2) original_env = result
    where arg                              = eval_with_env exp2 original_env
          new_env                          = env_write absenv string arg
          -- evaluate body in environment from closure + argument
          result                           = eval_with_env body new_env

-- application' expression
eval_with_env (App exp1 exp2) env = eval_with_env new_app env
    where first   = eval_with_env exp1 env
          new_app = App first exp2

-- abstraction
eval_with_env (Abs string type_str exp) env = new_abs
    where new_abs = AbsClosure string type_str exp env

-- Type Checking should have removed all *applied* TypeAbs
-- Has no influence on runtime but preserve TypeAbs
-- e.g. the top level expression could be an unapplied TypeAbs
-- cannot pass through an unapplied TypeAbs
eval_with_env exp@(TypeAbs _ _) _ = exp

-- Type Checking should remove all TypeApp
-- this being here is an error
-- cannot pass through a TypeAbs
eval_with_env exp@(TypeApp _ _) _ = exp

eval :: Exp -> Exp
eval exp = result
    where blank_env  = env_new
          result     = eval_with_env exp blank_env

