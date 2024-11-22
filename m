Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E815B149
	for <linux-rt-devel@lists.linux.dev>; Fri, 22 Nov 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263289; cv=none; b=EhKyvMUu6OCDsJvkK3TMKgj9Cy5Xuw7/yFi1XGovoBrl1suEfA1GLSl8MYHYGDzyV+UmNVc0UFs/Txvt/J7tm2SLTyS0j46VNUV4k7v/Tzq71069ua6I8heJwBzKjhGM/uNqQWecBzFQJTqjttFtzQcVXRszVq1AugTsy7XZnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263289; c=relaxed/simple;
	bh=qcwewDRgaD8gm+fKgWbuxpBo55nR+NI6TrCl4SNLY+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shWngNRrtA1ZdDEY3pc3mILjoVXJtvUbusAVLg7grmaJobShIL0tHL5ydqg6UKOEsKbArKkC4F2CrcltN3JibWKNo9Lh+5UBLoJYHc1f2/1R+s6mZ1YVNoi21NNThN0sbWrtUGGsZWrbHY9zcE0XofeYTjHBCAHAc0f3mhUcHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8/CePgd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ty9nn9U9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8/CePgd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ty9nn9U9"
Date: Fri, 22 Nov 2024 09:14:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732263279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5f2KKQBZsbL1m3fb5DYI0rcFDbRUsBKOLW2TE7xMXs=;
	b=X8/CePgdUUdEnwy6Fi2ZFBHOa9AEprEVeoMWD3xDy01h2FB+x+EirdMXc5Jd9MugW1X2Vm
	VSS9vV3+uTloDZ7+EqsVPFs5AJ9Z9dpVcBlHQE2Uvj8PhlZ/PNBU2fw/BQiiZmZRASv1E+
	9bZIuLzZPFSZcjYllNDZLvNXiwAvJRL9o+0PGGhzZ1UGk1+OHxF6Slhamz3GX6TEuZjBQx
	CBAeNE3LF3BeLcshQrS6i6ripYEpVo23sMsNSaj+HrEqbkda4qVXxcjWgzSeH0yhEDnv/m
	DHXNx2CmDgHsZjCGTQuU3A2cXXp6RnTVGj8+vnfutyqF2/nv0YefyzQrrijH8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732263279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5f2KKQBZsbL1m3fb5DYI0rcFDbRUsBKOLW2TE7xMXs=;
	b=ty9nn9U91upjTVz6kKxbFz/p2pnkJeqnDd60WHqElO+N2rl6a9ra3vA6HupAVB7lKWBnUf
	0T8I3AsFwcMeXLBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241122081437.AKxGgM9n@linutronix.de>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
 <Zz-HqbsWxFPrrjST@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zz-HqbsWxFPrrjST@arm.com>

On 2024-11-21 19:19:05 [+0000], Catalin Marinas wrote:
=E2=80=A6
> > Maybe SELinux locks should be converted to raw? I don't know how long t=
hat
> > lock is held. There are some loops though :-/
> >=20
> > avc_insert():
> >=20
> > 	spin_lock_irqsave(lock, flag);
> > 	hlist_for_each_entry(pos, head, list) {
> > 		if (pos->ae.ssid =3D=3D ssid &&
> > 			pos->ae.tsid =3D=3D tsid &&
> > 			pos->ae.tclass =3D=3D tclass) {
> > 			avc_node_replace(node, pos);
> > 			goto found;
> > 		}
> > 	}
> > 	hlist_add_head_rcu(&node->list, head);
> > found:
> > 	spin_unlock_irqrestore(lock, flag);
> >=20
> > Perhaps that could be converted to simple RCU?
> >=20
> > As I'm sure there's other places that call vsprintf() under a raw_spin_=
lock
> > or non-preemptable context, perhaps this should be the fix we do.
>=20
> My preference would also be to convert SELinux rather than avoiding the
> issue in kmemleak (and other similar places).

No. kmemleak has been made use a raw_spinlock_t because most of what it
does is something that is not used in production on a PREEMPT_RT system
and falls in the same category as lockdep for instance. And that code
calls into LSM/ selinux.
Before making the lock in selinux a raw_spinlock_t you have to think
about the consequences in general and audit the code. From a quick
look, there is also avc_insert() invoked in that callchain which
allocates memory and this is a no no.
Also, if you make the solution here in selinux to use a raw_spinlock_t
you would have to do it also in every LSM as they might be used instead
of selinux.

Therefore, I still prefer adding PREEMPT_RT to the restricted_pointer()
category for atomic invocations.

Sebastian
