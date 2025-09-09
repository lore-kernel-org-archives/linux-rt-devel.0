Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FDB305942
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403151; cv=none; b=IXPZnHdtysYTeOjN9F0GDStykHOJDBO+90kfrXmC0OAnHeDlLtuKCbg4iANqLL3+VSV1IMs1cs0mh5hM9dfN3KJq+mYBNUaZiNBUy7GCbdrLokwrtcbpExbNmNpzZFTexGwdksvfeFY+ZmSDTFHJEGCr0qwvJ9cWmva/SdrNk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403151; c=relaxed/simple;
	bh=jxu58yw/hxGvrdsBGTlthehYAKHBydBvk2WVIbmyeFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWwPT+y4Hc4XJajy4POQ7ZFAji0BSWV0gJ4JAO6vWhZYy4ypiB2fFUSDHlZdHN21FYR+3aCKsdrI+/dGQ6RvXgL5iYh3jR7rG1BeySmzNi87Z0Q5aqdRk6AzrsY22IsCkA9M4T25adfHoEfArpLPhFZLUUSwlxrKCZygSOD4YXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ITpPiVtH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qCHOn4mk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ITpPiVtH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qCHOn4mk"
Date: Tue, 9 Sep 2025 09:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757403147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLb5+Vhpe6PI/G5tosSBd5U7V2v4fzK4TiNFcee0z4A=;
	b=ITpPiVtHmBSNMup9IxcRd6Ucuw5DZoxAVXDF9jJDiBKA+iOMJV5w1vaLZCiuav9f9L3AIq
	4+WWSYNwLRjaXeKemYA/KzeGV8hL5FQ9seTntErnU5NMQNccUa81j+gim6r66KZD1Bmo4U
	dsRGanpoX5IowVo2WlNShCeIrEbhFbEEh7agAbBI2+5fPY7E085a12HmFV4B6TRIWGbC7H
	vp/2+7Ds8Pkrnq+ab8ACKJdDQO7L5UfpoOSGmIV1bQ+FHYrzjvtf10chmI1p4ydB0DwvsX
	/JjL1l1OrKTbGXAo4qHMvbmDgaYD1MClRPAPK7U7q9lYpGudfxWNSlkZJblv/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757403147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLb5+Vhpe6PI/G5tosSBd5U7V2v4fzK4TiNFcee0z4A=;
	b=qCHOn4mkMvaoBbP16U3N54P4NiJjyz9ScR8u78/FTQTxAd1ZKbSQRByeQfVkqhIticXhL1
	Fdmi1EmT2aH7XdDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: libc-alpha@sourceware.org, John Ogness <john.ogness@linutronix.de>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
Message-ID: <20250909073226.0qoHYZMo@linutronix.de>
References: <20250908163329.Qq79ujq_@linutronix.de>
 <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>

On 2025-09-08 14:46:12 [-0300], Adhemerval Zanella Netto wrote:
> > This change expects that PI-FUTEX is supported by the kernel. This is
> > the case since a long time but it is possible to disable the FUTEX
> > subsystem or the FUTEX_PI part of it while building the kernel.
> > Is it okay to assume that PI-FUTEX is available or should there be a
> > check somewhere during startup and in case of -ENOSYS a fallback to
> > current implementation?
>=20
> We removed the __ASSUME_FUTEX_LOCK_PI (f5c77f78ec03363d5e550c4996deb75ee3=
f2e32a)
> in favor or always check for PI support at runtime during pthread_mutex_i=
nit
> (prio_inherit_missing).
>=20
> Since the kernel still might return ENOSYS for FUTEX_PI I think we should
> keep probing its support as runtime.

Okay. Since that one is static, I guess I would have to make my own
check in pthread_cond.

But=E2=80=A6 Now that I look at it again. The kernel has this FUTEX_PI opti=
on
which depends on RT_MUTEXES. But RT_MUTEXES has no off switch so it must
always be selected once FUTEX itself is enabled. The I2C subsystem
selects RT_MUTEXES and I don't think there is a config without PI-FUTEX
considering this.
We _used_ to have runtime detection for PI-FUTEX support because not all
architectures provided a cmpxchg function for futex. This is gone and
all architectures as of v5.17 provide it. That would be commit
   3297481d688a5 ("futex: Remove futex_cmpxchg detection")
   https://git.kernel.org/torvalds/c/3297481d688a5

for reference. So I *think* this config option can be removed on kernel
side and it appears to me as of v5.17 there should be no need for a
runtime check regarding PI-futex.

> > --- a/nptl/pthread_cond_common.c
> > +++ b/nptl/pthread_cond_common.c
> > @@ -106,41 +106,23 @@ __condvar_fetch_xor_wseq_release (pthread_cond_t =
*cond, unsigned int val)
=E2=80=A6
> >  static void __attribute__ ((unused))
> >  __condvar_acquire_lock (pthread_cond_t *cond, int private)
> >  {
=E2=80=A6
> > +      int e;
> > +
> > +      e =3D __futex_lock_pi64 (&cond->__data.__pi_lock, 0, NULL, priva=
te);
> > +      if (e !=3D 0)
> > +        futex_fatal_error ();
>=20
> The __futex_lock_pi64 already issues futex_fatal_error() non-expected ret=
urn code;
> so I think we should only use it futex-internal.{c,h}.

There shouldn't be any error. There might be the case where the lock
owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
handled now but it can't be recognized either. It would require to kill
the thread owning the lock.
So either abort the operation if the futex-op returns an error because
"this shouldn't happen" or I don't know.

> And I think we will need to handle ENOSYS here, maybe to use the old lock=
ing logic
> if the kernel does not support FUTEX_PI. I think it should be fair to ass=
ume that
> if your running your workload on an environment without FUTEX_PI support =
you are
> not subject to the issue you raised.

Yes, that is fair to assume. Also given the above it might be a
leftover. But let me add the fallback code and then we can remove once
it is certain on Kernel's side.

> I am ccing Carlos, he has helped fix some issue on cond vars recently and=
 he
> might have some idea if using PI aware locks does make sense here.
>=20
> Also, I think we really need regression testcases for this change.

I came up with something to test this. It required a few CPUs and task
pinning otherwise the small window didn't trigger.

> >      }
> >  }

Sebastian
