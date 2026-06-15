Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5338411667
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544123; cv=none; b=iAWRbXkSf82I9+RQWO2OPWh7dunwvWvPtvHxUX5Nm8sdbao+DvAdEVlitJocoeqgyg8BVkarzQwuBJxFZA14HLtMRACHUNgGD19viJbjcSYJgdExYIqOuYsUzuCnw7XRAWFmn75eN72CmjKjj90vCSsqV7+NfLuBvlWgetqPAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544123; c=relaxed/simple;
	bh=QoyBWl8N0Lv138cX/ZGqgqOFnA1rVTP6LC3SFjrQZA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjQVyY9L3GT61HARePBo26KZkKRsVaz2XtJEALkWZ+KySgkGCDlM2BJoOMTYeD/mEND4eCVN31g3VT4hNOo505Y0axX3k1Yh8rcti7YF1RTMCaOiaN2a89LIwo2KaP19E++WGEZbsScNqN0Rde9ZkV6OCmeHRlikcDrBgT3Y9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwdVrvNT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bF2Jx9Dj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwdVrvNT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bF2Jx9Dj"
Date: Mon, 15 Jun 2026 19:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781544120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g36MIwpGYoz3X7VL1Yutn+HhGIx2EjVVLG9IrRo4XS8=;
	b=AwdVrvNTMnPiP117pH+w8Yusw6Pu9fpqsyY/bfv0hfJ9glQiTBK7M5v6xyuI+/od5zUjAV
	Nwb/yR1D6G2D27VWA/9Ajka/728BGF5OzevCisU98XPgaznpZdmJgC3NDfyItFWFXoAsQr
	fvBW3s35VfsU2Hz8Q0I/qMwuBR/7UZP3wK0yG40bAJEzhc0dyxcECkreKSY9y8jNGEiBb6
	gcYC3sI+LGSc3U6b27t17nyukhwU3FdWGytMtwCHNQTkY5GZsmfEPZJTiLt0b2y1HubbTZ
	yMCCZRtrMzS1zc5SLZE8KFrkw3GzwgQjnymC1/a0eBkOoXsbKSa9p/dcED9Asw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781544120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g36MIwpGYoz3X7VL1Yutn+HhGIx2EjVVLG9IrRo4XS8=;
	b=bF2Jx9DjIAugTGfzqoeBJPeJfR2Oft6+R/cw7JPECtOjFGNdrEoN16C4yoqQlIfbIArarO
	YvsEFaxd9OJCvuBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <20260615172158.AoVQ3Q3K@linutronix.de>
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
 <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>
 <20260528145124.v9o6OcOc@linutronix.de>
 <20260528153554.vllN7_T9@linutronix.de>
 <aho0eqjMESuHxECr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aho0eqjMESuHxECr@redhat.com>

On 2026-05-29 21:51:06 [-0300], Luis Claudio R. Goncalves wrote:
> On Thu, May 28, 2026 at 05:35:54PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-05-28 16:51:24 [+0200], To Waiman Long wrote:
> > > > The kernel backtrace is produced using the latest v7.1-rc4 kernel. There are
> > > > a number of changes to the debug_exception_enter() and
> > > > debug_exception_exit() functions over the years, but the preemption disable
> > > > code remains since its introduction in v5.3.
> > > 
> > > Let me look at this again.
> > 
> > So how do you reproduce this? The calls within debug_exception_enter()/
> > exit() look harmless or I miss the big thing here.
> > From your backtrace, you have brk_handler() and this is gone since
> > commit 31575e11ecf7e ("arm64: debug: split brk64 exception entry") which
> > is v6.17-rc1. I can use gdb with breakpoint handling.
> 
> Sebastian, in the original series Ada provided a few tests, including the
> two files I list below. Running that test in a v7.1-rc5 kernel with
> PREEMPT_RT and DEBUG_ATOMIC_SLEEP enabled, I get this backtrace:

This is a reminder to myself that I need to look at this since it does
not look solved with the breakpoint patches. But this is also perf.

Sebastian
