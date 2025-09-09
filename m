Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF52571C2
	for <linux-rt-devel@lists.linux.dev>; Tue,  9 Sep 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433147; cv=none; b=OutQq/6RjFTcjC6FJgeDRq0fj50TIZjVylBQzBb1+Q6a7Dwx8MY+/81vTTJBIjYr2Qy2G4Y9su+DxwgA84t/uyrq3C65OVS/aOeQ7nL7Kdo44WxkV7N/ZpxLQjFOdLOjMmw4ZZgJXM6Wt78dfN3XL5wCcVKDOnwTaj1RlaSZ17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433147; c=relaxed/simple;
	bh=ER1fOGXDsY3BQjFXEjTJrYkjK6cN179OloVJhuZNHYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhF+aepXsUyrvV/3yJ1XcmTFzseC+wPf51cjhCj4lj5A6p1twIsnJEgmwbCkt9R02OAUs3jAfYNbzYNXNb7aPLeW04qcpyG8nVoP0+Nv7FmbsFBo4A0MzVmT37PfwPkMGnylC2B2nwdAUfZtFJuSdR/lQAaN+FNCV16h2FZyMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKUGvBD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZO+38Rp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKUGvBD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZO+38Rp"
Date: Tue, 9 Sep 2025 17:52:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757433143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/JcQ03Eq7Ovu2Qdkc+aGY5xW3gkjSemI1fUA2u8xx8=;
	b=uKUGvBD/tGvBWO/ptmZ/8BftLV42ZZ9OkSJCabbM0iveRu5HogY2TLtmesPwXQb1VmTMSC
	FLUyU9fcKIyiMEmL3en0It2eMEsYK+5aC4jYrZl+7ayeb9XbKN3qhJWvJJykrOh5CoHFDl
	07D8tWr3JLyKkR/u2V3teTTheQrlevGrk/KGaVckZyv/qHhXpNcUyAAsX4k8ePf1/rA85D
	lFrrjeIFHO4movtU5G/hKehPBroZAqljbLm89JVz1k3wiFUkcCv1Rvyr6EeSN74JgyO1aB
	E910rENcG/OSMrN3YyRclvPGw+jJDuprNVwhpZbsdQMWV8kCo1sv4gCkygFdoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757433143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/JcQ03Eq7Ovu2Qdkc+aGY5xW3gkjSemI1fUA2u8xx8=;
	b=sZO+38Rp5jzDttGLIBkz8FzroJhSm99vv0+nul5C0KntCvyWsJ7uQpAHtE99dozlJFK0mE
	PcTcd6by5rBJWsCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: libc-alpha@sourceware.org, John Ogness <john.ogness@linutronix.de>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] nptl: Use a PI-aware lock for internal
 pthread_cond-related locking
Message-ID: <20250909155222.dbSsn8e5@linutronix.de>
References: <20250908163329.Qq79ujq_@linutronix.de>
 <4c9c86ae-a432-47fe-bede-7f98f4bb1f7c@linaro.org>
 <20250909073226.0qoHYZMo@linutronix.de>
 <660fc0c9-7768-4812-b532-5afc94131cf8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <660fc0c9-7768-4812-b532-5afc94131cf8@linaro.org>

On 2025-09-09 10:09:36 [-0300], Adhemerval Zanella Netto wrote:
> > Okay. Since that one is static, I guess I would have to make my own
> > check in pthread_cond.
> >=20
>=20
> Or move the prio_inherit_missing to its own TU and use is an internal
> symbol.
okay.

> Right, but at least for glibc we will need to keep the runtime check
> because we still support old kernels.

I see. Is there a minimum old kernel? And will this increased somehow
based on LTS support or y2038 requirements?

Basically we have this due to old ARM machines :)

> >>> --- a/nptl/pthread_cond_common.c
> >>> +++ b/nptl/pthread_cond_common.c
> >>> @@ -106,41 +106,23 @@ __condvar_fetch_xor_wseq_release (pthread_cond_=
t *cond, unsigned int val)
> > =E2=80=A6
> >>>  static void __attribute__ ((unused))
> >>>  __condvar_acquire_lock (pthread_cond_t *cond, int private)
> >>>  {
> > =E2=80=A6
> >>> +      int e;
> >>> +
> >>> +      e =3D __futex_lock_pi64 (&cond->__data.__pi_lock, 0, NULL, pri=
vate);
> >>> +      if (e !=3D 0)
> >>> +        futex_fatal_error ();
> >>
> >> The __futex_lock_pi64 already issues futex_fatal_error() non-expected =
return code;
> >> so I think we should only use it futex-internal.{c,h}.
> >=20
> > There shouldn't be any error. There might be the case where the lock
> > owner is gone (ESRCH I believe) or the theoretical ENOMEM. ESRCH isn't
> > handled now but it can't be recognized either. It would require to kill
> > the thread owning the lock.
> > So either abort the operation if the futex-op returns an error because
> > "this shouldn't happen" or I don't know.
> >=20
>=20
> On pthread_mutex_lock we handle ESRCH only for non-robust PI mutexes, and
> we delay the thread indefinitely. I am not sure which is the best approac=
h,
> but I am tending for the delay one for consistency.

As I wrote in my other mail, we should somehow consider this dead-owner
case but can do this loop for consistency.

> >> I am ccing Carlos, he has helped fix some issue on cond vars recently =
and he
> >> might have some idea if using PI aware locks does make sense here.
> >>
> >> Also, I think we really need regression testcases for this change.
> >=20
> > I came up with something to test this. It required a few CPUs and task
> > pinning otherwise the small window didn't trigger.
>=20
> Right, I think the idea would to provide a way to over multiples runs from
> multiple developers in multiple machines we can assume that this is trigg=
ered.
> I agree that for such problems is really hard to come up with reliable te=
st
> cases without spending a lot of cpu time.

Let me clean this up, follow the testsuite approach. I did verify it in
the with the syscall tracer that the case triggered. So it run a few
times and assume it touched the PI paths.

> >=20
> >>>      }
> >>>  }

Sebastian
