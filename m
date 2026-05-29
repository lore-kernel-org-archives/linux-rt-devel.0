Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176543403EC
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039176; cv=none; b=cnE20zJ0TGEh1kEXh/qCjmWnKaXQKEfm4uH8Q4BPDlhr8uqf9AGI0tIU4YjSe5m9LGjfnVKiUIOF4H0t0cqOPR+Gok0qVgKC3mv2ObLdn6IOyK+Dl8KipSMFdgxS7282WLkgZhdx3IXhOTMxCbORNntRbCovvy7Dv1ivfj2ASAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039176; c=relaxed/simple;
	bh=0BbmYJr6d+G9gN3ELFWarbFyFlgTvJ5Ks9xwMhbD5GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrs0UvP8VLT+EE4Wb3EDs5XkXVH0fYRIRK4UDJENBaem9UruEPs9o6Efw+JiiJKyPffDc0/WkVfxc1O+HV1o93k05DL/cG6zKSwMK7RrwNIlK22z9bFwDHuaYYgCU5pq83XfsW1k/RCsSLSYRT+u2NHzGIC4J1Xq6UPEW4pHC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2PWQKiM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oO/+BWHS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2PWQKiM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oO/+BWHS"
Date: Fri, 29 May 2026 09:19:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780039173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRgrxr0v93pNHjd9KJ45LJxkAxA70PHhjqWCNTwglXU=;
	b=P2PWQKiM80BoE+UMtp+aIP3wyqPlG5bOhL9IDPQYe+zfJwZC98f+qJ/BmO3g9FE5wg32EH
	tuNnqNVOSaQy0d+CqpXRceWhXovDUGnhfEpU8VNgqiq2VmSCMsbUcmYoe77MwYgfETUg4S
	MZJmnPorasd0vScusJC4gi/7iQgCkBdfq1ZgkOSLOJkg/izbmVhNyRcKxL8goALCqnD5Gd
	862KP/44O8iVHjSyOd4hlZCPg7E+8b5+EO/9JE6acK2tYzEHcTPX77I5WrwyueSgIaeHyT
	YvJyGR+E/vTT3VBITQOPnHvXVq9mNIstkeBSsXPKiuLWJUPs9WSbRpuDkcD10A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780039173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRgrxr0v93pNHjd9KJ45LJxkAxA70PHhjqWCNTwglXU=;
	b=oO/+BWHSyaRj/wTaJrv+ugi8II05BOj/0P+XK+FlMmil4fMwilK3G37GKtpEnBtfyW2/4V
	KemLk8z9kxvk2mDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>, linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Message-ID: <20260529071931.nSO7Uqb2@linutronix.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
 <20260528074939.7MLrIhrM@linutronix.de>
 <ahhl8dZ-uMM8gmDO@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ahhl8dZ-uMM8gmDO@mozart.vkv.me>

On 2026-05-28 08:57:37 [-0700], Calvin Owens wrote:
=E2=80=A6
> > This does not work because the commit message claims to allow
> > pps_event() to be called from hardirq context. So if this is called
> > indeed from hardirq, context as claimed in the commit message, then
> > dropping the lock early does not help here.
>=20
> It isn't called from hardirq AFAICS.
>=20
> > Does it need to call pps_event() in hardirq? Patch #1 takes the
> > timestamp in hardirq deferring the remaining part to the thread. What is
> > the crucial part here that needs to happen in hardirq context?
>=20
> This is the artificial testcase which just uses a ktimer, it both
> "samples" the time and calls pps_event() from the same timer callback.
>=20
> But I understood you to be saying it's threaded above, which mirrors my
> own understanding. If that's true, I don't see why dropping the lock
> early wouldn't be sufficient here?

So lets look at the series:
- #1 splits the handler to take time stamp in hardirq and the remaining
  work in the thread. It seems to be crucial to do so because doing so
  in thread breaks something. Okay. Granted, makes a bit of sense.

- #2 ignore for argument's sake

- #3 says swap the lock so we can use pps_event() in hardirq context.

Now. Why or where do we need to use pps_event() in hardirq context?
If we use pps_event() is used in hardirq context, as claimed in the
commit message, then dropping the lock early here does not help and it
will lead to the same splat in wake_up_interruptible_all() because
interrupts are still disabled independent of the lock here. It is
hardirq-context after all.

You don't see this warning in your testcase because it gets here from a
timer, yes. But. pps_event() can't be used as-is from hardirq context
either.

> This is what lockdep says on v6:
>=20
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     [ BUG: Invalid wait context ]
=E2=80=A6
>     -----------------------------
>     ktimers/0/15 is trying to lock:
>     ffff888107303118 (&pps->queue){....}-{3:3}, at: __wake_up+0x1f/0x50
>     other info that might help us debug this:
=E2=80=A6
> If I drop the lock early, lockdep and atomic_sleep are both slient.

Yes and might_sleep() would yell, too.

> Thanks,
> Calvin

Sebastian
