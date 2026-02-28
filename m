Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA63426D18
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275702; cv=none; b=jTlQ9GdFLs6R/g/WoLUeOphOkXgdl0VRI8EUFcK3kAJpBXOkbTtD/rqSYPrN+yK5veQHdFiWzuyyBmRzY4o8AuIph1LESlXKajyf7maYRzKzJgf0fzoy6sTtHyd0s1Jt4SUGxmfYHV9cyeI4Rjbcby5J9hVDXaVrcPPNcyk/DFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275702; c=relaxed/simple;
	bh=zNYIuATfptBMQBGj8OWYMi6vXnwctmZSzqd1cVojdLA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dbZ7p7nxiZN3qo/hp2KrTmNKKgo/px6X1StecacHXZPO8ycOggBqsgiYmQx0AnzaOXQZr/oCO1OGHRi8BjGdHzdo2mOFLn7RSGRT6MGcW+wFTT+jB3k/8Q39L7Ke0C8tex5Ld6VKlHWoIpYIr0pIEfb2aUKlcxP/tUZwWHct5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=INl+i8x0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="INl+i8x0"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772275698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3dTyK+LLrJj1nEK0N0NozOKKCbPA2IihWiC3dYoP3w=;
	b=INl+i8x09YtKn5fIHFB0WcmvgiGR3VESSo8x1+UTh0dOpM5E3/vEsrGGuGo/gGqziBcd8y
	heWqcCEDdw6++RqIDWK2IjlPaYQYwwE/zW0Ek9U3BJr2GAzGTJa4fEMh4f7OC3aOzAfkpy
	VQxj7p7hluuF6JXg7ME6x7xwUkkVcIg=
Date: Sat, 28 Feb 2026 10:48:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <144847b602a9613d3f91943348294cad3eba6678@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] net: fix sock compilation error under
 CONFIG_PREEMPT_RT
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>, "David S.
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jason Xing" <kerneljasonxing@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <CANn89iLphv9XtPnW5Bw1UETNoZZO+rdifQfzC8MxYM+gNHAcTA@mail.gmail.com>
References: <20260228090644.362807-1-jiayuan.chen@linux.dev>
 <CANn89iLphv9XtPnW5Bw1UETNoZZO+rdifQfzC8MxYM+gNHAcTA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

February 28, 2026 at 18:43, "Eric Dumazet" <edumazet@google.com mailto:ed=
umazet@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E=
 > wrote:


>=20
>=20On Sat, Feb 28, 2026 at 10:07 AM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20>  When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands =
to a
> >  brace-enclosed initializer rather than a compound literal, which can=
not
> >  be used in assignment expressions. This causes a build failure:
> >=20
>=20>  net/core/sock.c:3787:29: error: expected expression before '{' tok=
en
> >  3787 | tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> >=20
>=20>  Use declaration-with-initializer instead of assignment, consistent=
 with
> >  how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
> >  DEFINE_SPINLOCK).
> >=20
>=20>  Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()=
")
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  ---
> >  net/core/sock.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
>=20>  diff --git a/net/core/sock.c b/net/core/sock.c
> >  index 9d841975a7a1..2461aba7b18a 100644
> >  --- a/net/core/sock.c
> >  +++ b/net/core/sock.c
> >  @@ -3782,12 +3782,10 @@ void noinline lock_sock_nested(struct sock *=
sk, int subclass)
> >  might_sleep();
> >  #ifdef CONFIG_64BIT
> >  if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> >  - socket_lock_t tmp, old;
> >  -
> >  - tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> >  - tmp.owned =3D 1;
> >  - old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
> >  - old.owned =3D 0;
> >  + socket_lock_t tmp =3D { .slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock)=
,
> >  + .owned =3D 1 };
> >  + socket_lock_t old =3D { .slock =3D __SPIN_LOCK_UNLOCKED(old.slock)=
,
> >  + .owned =3D 0 };
> >  if (likely(try_cmpxchg(&sk->sk_lock.combined,
> >  &old.combined, tmp.combined)))
> >  return;
> >=20
>=20Thanks for your patch, could you please use a nicer formatting ?
> (And keep an empty line between variables and code)

Ack. I will send it later.=20

>=20diff --git a/net/core/sock.c b/net/core/sock.c
> index 9d841975a7a14a12769450a8d937af96f7777070..fba4d5b8553c58f700bda3d=
bd82ce68ec74187da
> 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3782,12 +3782,15 @@ void noinline lock_sock_nested(struct sock
> *sk, int subclass)
>  might_sleep();
>  #ifdef CONFIG_64BIT
>  if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> - socket_lock_t tmp, old;
> + socket_lock_t tmp =3D {
> + .slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock),
> + .owned =3D 1,
> + };
> + socket_lock_t old =3D {
> + .slock =3D __SPIN_LOCK_UNLOCKED(old.slock),
> + .owned =3D 0,
> + };
>=20
>=20- tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> - tmp.owned =3D 1;
> - old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
> - old.owned =3D 0;
>  if (likely(try_cmpxchg(&sk->sk_lock.combined,
>  &old.combined, tmp.combined)))
>  return;
>
