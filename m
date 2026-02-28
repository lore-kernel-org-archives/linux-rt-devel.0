Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF1423178
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275432; cv=pass; b=ZrZ6yLHKjQtCbGi91niLRMmelLWkXCOzYpFdqdDLhVx6yYx1maxJt+GX8dWv7+5/AUWISfyXZ2HX/C4BOXWT0C3E2A82d89tyk+H79RXEooJE3SjHKqKtvWuanTSxDfmB5S5bqYmYNxFibDJ4t7dwEabqCrF2kj2nnd0USzLLRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275432; c=relaxed/simple;
	bh=byrV1y01S9ZllwpxdPTd0kag3viPIA43uIwxs2gGxYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIknM9tG3Ae+n/rd63lVDpnUPeOipc1i6uCe6F87RiDMrEixrfLDra9wX7ArYVSRuni3asNcBaYPoKp5FECZqpufwDw7wWKRkvy1uDxdeE1yWR4jmAshisB18P8d5iCocwuZr/Xh8BjzgKhOy3QWLGS8G3OwaQyWt2ipNBIAElc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAaOKlq9; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAaOKlq9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb4081e82aso392028485a.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 02:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772275429; cv=none;
        d=google.com; s=arc-20240605;
        b=Ye4aohINN78vwmhwG+Yux3KQkFjE87mljjXyYfCFL+4CFuAVN1+xjAT8TNS5ADx7oi
         EhwnH1qWFqgShzA2x28qnhCtzQK8rqJ3MDE2L0EOVp2421uJlxw7VEoW8bwrfwy481b+
         7LdynZ98uO1mirC+FFQe3m8xqd5mZmQ/c5nWJtfL1BrX+fUpLYjNnJWjNi7K6FxN+UHA
         gST2qJVIT2GNkhLiKcpbHYQjhRTGckP/eY6XR/dpcR/4OcEptpzqenEf/iOjILlnELPy
         raMkcHoUCi5JsGXWDUYxnPY8eml+3WohU3fVPmDFIvtYMQ9/2XzUNSzZFVQzO/xIyHCq
         3ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        fh=FhBEzorYlP4gCVZi48fWZw9PZbAb2axcIJhGh6cLQYY=;
        b=Q2IqFQdRmymTy/jQg/frGAPzLGRpp1Xc10ClsjZZnHqhCsCjzFriNr7jkv0OMf2aCw
         XD17GSbfhdhksPg4bBvRDA5YfVFdThkN/NwX4KWKMeScnhrrOdIV1byLnAeEGQrolDNn
         9aHjNo9P2dYAICuRZSNBIWjZPyr/RrhoopaqEcnjY2teuq31A4Uqb4oVIFBKQCRSLgAy
         z6Lh2B2WSdfOiw1nlx9m7v+wt82svWKKVVC4jN+hWJJXQCpelBZQDzase5tk5qtybNrY
         E3VF5H1pOzvesUlNplosf5wUhqTLMBP5M2UHgRJgZIOxrJsVPxMfHW1ErFyKZ9WzO/mA
         SEGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772275429; x=1772880229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        b=yAaOKlq9MtzOJH3JzfiUH3cxMuxfzlSDURlLZ0y+QxrhJiVHIj5OmfsEBYQiNhWL99
         iZw9zwJ0lYub1heLbaQpFeMbc0RUBcbQNbZyQGVEJh6Fh4UPMeH3L/gUvxAYAnX928J4
         Oh1G7Vco3Xs40sHDQh6wN5WAnOJeK8+rkTdWj3gCvBdtSncgkgUx+dXy5HcpWsy+3Ocm
         x+cEX4cyoosbWnCL0W3fXQKmFGzfaF2xriH2ozFTKXLEA/6P4dNTyy5dRV9awlgXWsN9
         W5To23+1AB8abzZbpEOu1BcdA2DXXiM+oeUv5ldJ8duR4EbZGvK0iXoB8GWo5E0b9HpJ
         du9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772275429; x=1772880229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZJhX6NxH0yZaapEa7kWGpzdjrbqmINjKypnHa5DKd4=;
        b=E72siPspPQLcv/lTMKBoUR9V4DF0NmqABuJQtkd0UChWql+quwsqeFaTzdeaiWFqPV
         oI3+KWZpLtjv0a+peNZUdYfC4aO82kFE+vstch5ey/YLKBex5JP/9lKBJO35FTx6V9Cj
         3HKg77Q8kCZ0vd3ZVouMeAi357/PWZubcIXBa5C+rjhXXqFizx3Ogqb1vzBwhZTSrFh1
         /NHddgL+KONdfroGQZEfwlrl2mG6KXqrB9wGeM5kYBrMJRDBVDbv2a2xp+Vc0FvNW3cm
         jZ7+ngJwLquUp9XgZlDZjbTtMiyzDA7/ZmJzbK8noDSRSwk8cInmBPE9atmqWPk0HIac
         KpBA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4XCXBEGIAwsewQcU9N7fsdwjhk7xiMVYVEsLjtLI0ZEAv8wEAXmRg9ISOMBYyO1V7qraJCbSTJQNCeeRsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzjBsgZzBMxhixKwyxQ60eWGRmtjCs3HaWFEFgELXZ+/lmwY2r
	RfnQoWP8iYR62B4l/oVMM+pvA0jY8g5ng6THsEghqdIVIOXGeZYlttY6gI54nv39D5inO6E/ctx
	mPbXj8dB3V8eaeDYUmczkBrp67uVs8cZl/suH9Sp9
X-Gm-Gg: ATEYQzx7IgNeP5CIXIxHgNEmTDaMiy2F/16CGzUyya84FgNDHPZjRxYmYEd2vgP7sMM
	kz/wfMceppPRGG16C1s10bt23w02YfHRP7Js58RPL2HfTCIki8h20Ogb6wEGcXN4NjEae/nUjg9
	78IFJq6vPaluRxza5hihmO6Y58kfxnHnoXYWUxJMV+pCRJ9sMYX9p7Mwae9gOhGezm/uh/TD+Fl
	PG3S9PVA7sgdM5x+TdDkbVuA+bmuVfwi6jHQO8Zas01V6UB+r9C6stldFYpsBpszn3jz36pwGbA
	uDxB+t6l
X-Received: by 2002:a05:622a:15c9:b0:506:a50b:3a8f with SMTP id
 d75a77b69052e-507527a412dmr72813731cf.30.1772275429198; Sat, 28 Feb 2026
 02:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260228090644.362807-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228090644.362807-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 11:43:36 +0100
X-Gm-Features: AaiRm504Md_PN1rDK-Pt41giHnp4Eh_LDEFUnni68ItoT1ge6iwGLdz8b9wfpg0
Message-ID: <CANn89iLphv9XtPnW5Bw1UETNoZZO+rdifQfzC8MxYM+gNHAcTA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: fix sock compilation error under CONFIG_PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 10:07=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
> brace-enclosed initializer rather than a compound literal, which cannot
> be used in assignment expressions. This causes a build failure:
>
>   net/core/sock.c:3787:29: error: expected expression before '{' token
>    3787 |                 tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
>
> Use declaration-with-initializer instead of assignment, consistent with
> how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
> DEFINE_SPINLOCK).
>
> Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  net/core/sock.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9d841975a7a1..2461aba7b18a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3782,12 +3782,10 @@ void noinline lock_sock_nested(struct sock *sk, i=
nt subclass)
>         might_sleep();
>  #ifdef CONFIG_64BIT
>         if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
> -               socket_lock_t tmp, old;
> -
> -               tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
> -               tmp.owned =3D 1;
> -               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
> -               old.owned =3D 0;
> +               socket_lock_t tmp =3D { .slock =3D __SPIN_LOCK_UNLOCKED(t=
mp.slock),
> +                                     .owned =3D 1 };
> +               socket_lock_t old =3D { .slock =3D __SPIN_LOCK_UNLOCKED(o=
ld.slock),
> +                                     .owned =3D 0 };
>                 if (likely(try_cmpxchg(&sk->sk_lock.combined,
>                                        &old.combined, tmp.combined)))
>                         return;

Thanks for your patch, could you please use a nicer formatting ?
(And keep an empty line between variables and code)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a14a12769450a8d937af96f7777070..fba4d5b8553c58f700bda3dbd82=
ce68ec74187da
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,15 @@ void noinline lock_sock_nested(struct sock
*sk, int subclass)
        might_sleep();
 #ifdef CONFIG_64BIT
        if (sizeof(struct slock_owned) =3D=3D sizeof(long)) {
-               socket_lock_t tmp, old;
+               socket_lock_t tmp =3D {
+                       .slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock),
+                       .owned =3D 1,
+               };
+               socket_lock_t old =3D {
+                       .slock =3D __SPIN_LOCK_UNLOCKED(old.slock),
+                       .owned =3D 0,
+               };

-               tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
-               tmp.owned =3D 1;
-               old.slock =3D __SPIN_LOCK_UNLOCKED(old.slock);
-               old.owned =3D 0;
                if (likely(try_cmpxchg(&sk->sk_lock.combined,
                                       &old.combined, tmp.combined)))
                        return;
