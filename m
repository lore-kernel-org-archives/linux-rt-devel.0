Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE573E8343
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979889; cv=none; b=HNg6S5xNo0DE6IZdwXXvyW6H77k/qDNJCx6/xNLkHuauc0Bt/NDCE5A47j3fVxwY5J1XxU8Y8nh9X1Gi7Zb0oaPF9zmP3Z4HwncclADiK/ommohv/zclpVdi8kVWJ80VmFJpajR6OobS/gVEgKtkXHNcod2pI4PGCqmurV9HQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979889; c=relaxed/simple;
	bh=tes9eETmhbrfgk7DfFhxjNPU/OcGWQZ/gxVtYb53dAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Z2BzYw9E7p4NMfsDNnkHI0btuWwNA2wVkOSK3HAslS1jvKHzc/94sT33LVG/y8/a2m2yRomZPOm2M3se+UVNcBqFaAESvQIuk8fTHrFre7yT90NrJbShQ70CpciyCKE2B5U2UCKZtqH2m2U6MralfJu+sZHub5MRobxNnts0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQ+ecjef; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EcyQZcyv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQ+ecjef";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EcyQZcyv"
Date: Thu, 28 May 2026 16:51:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tes9eETmhbrfgk7DfFhxjNPU/OcGWQZ/gxVtYb53dAs=;
	b=HQ+ecjefrhd3lKo7MeHDceYtACK026uCjbf8UALWbQ/+35vdGKaVpFiGU4woUFbHWXfBeM
	5tjZ9jrXOQOoqaTQG5a/b6jHNqMiTqr0qqNlVydmxNAoPSwDt/oUZE0Vfe+jPgzwcapJMn
	aicr1TsHin+oCcoopW3W/6nELXTACXHoR82yyUmaoTociOHgmiSTu+3u1ReKsMTEkhALxT
	Gygk4jplKr+IHFFpLO8ECxXBZ+TWwrwDiebG3GhMk1iVpm96h1ju/uoFYsWfDpXrEBwrMA
	Zl2qgUgHzAYn5NJuptua0lMfoVZn2zQDFeBxtz371ZO09OHKFlrZoTGjajIFWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tes9eETmhbrfgk7DfFhxjNPU/OcGWQZ/gxVtYb53dAs=;
	b=EcyQZcyvPwqkHd0bsycUUrYzpTPcKbm8V+X8RafeKTe+8lwAhygLrg9Uc9VH4m/j4HDMeE
	oxoP4RPvZDUcwWBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <20260528145124.v9o6OcOc@linutronix.de>
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
 <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>

On 2026-05-20 17:01:00 [-0400], Waiman Long wrote:
>=20
> On 5/20/26 2:19 AM, Sebastian Andrzej Siewior wrote:
> > On 2026-05-19 18:25:24 [-0400], Waiman Long wrote:
> > > Commit d8bb6718c4db ("arm64: Make debug exception handlers visible fr=
om
> > > RCU") introduces debug_exception_enter() and debug_exception_exit()
> > > where preemption is explicitly disabled. With a PREEMPT_RT debug kern=
el,
> > > the following bug report can happen.
> > =E2=80=A6
> >=20
> > What kernel is this? I have backport (which is being tested) for v6.6
> > and v6.12, the patches are from v6.17-rc1.
>=20
> The kernel backtrace is produced using the latest v7.1-rc4 kernel. There =
are
> a number of changes to the debug_exception_enter() and
> debug_exception_exit() functions over the years, but the preemption disab=
le
> code remains since its introduction in v5.3.

Let me look at this again.

> BTW, what v6.17-rc1 patches are you talking about?

https://lore.kernel.org/all/20260528144825.850351-1-bigeasy@linutronix.de/

> -Longman

Sebastian
