val tm1 = 
T1Mapp(T1Mlam("x", myoptn_cons(T1Pint), x), T1Mint(1))
where
{
  val x = T1Mvar("x")
}

val () = println!("tv1: ", t1erm_interp0(tm1))