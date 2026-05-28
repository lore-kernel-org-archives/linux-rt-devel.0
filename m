Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623E2EBB9E
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982557; cv=none; b=ejL4cVr5q3T2oDEbY1Xyuy5aeIOJwJltp38bQ7ze2zozvOAXIl+SImMNXf727eGX4ul14I8wgfm5gjJlglMlOPM5/A6VZKEPUhqkCvHFaSHoNMFSS4qBxnNfb4iGwIOi8zjekTmjA2BAt0SLfjFASqY2MOEYY4PT2LSYiI0jEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982557; c=relaxed/simple;
	bh=SP72Aws0IoAEhkQkKRc2/0B+0Mw+liHRUNqc7zRVg54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl9tdVw5etzyCevcKu1S+ENNcN3mALQUqT1/WfRU5xuO7Kt7fh2YqshGByCidKGnV2RGgQPYrscw66Pv+b7G9qHxIXsFEN//MXJvdABc4rIxsSNKdgRodzAw/PKL43rqGY+Bn7OjBWUlea1SVbeAeJbIOP6JTumu/RgcMPbzWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHrJv2QI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtxGoMec; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHrJv2QI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtxGoMec"
Date: Thu, 28 May 2026 17:35:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779982556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/O6690LTogXCGAhOuB5o8py5EPR7dtCvuZauWGkmhI=;
	b=GHrJv2QIks2eYRD0aUPEBExi74jaugW0snZuzUSQDV1bF3XYOLMB/sFCVjma/gpiuFTKbR
	Dym2lop4/3H17P1HlX5POiIXob6Aw8XVmTA3kinjQYIwhWzgkC1u8TzCSb+5uCdhdZ2NfU
	pXivUt8yFTnWQdPBiqbgdaPQW7pEHTM1eLlXoHTGOt/pKfEu49b9oNtbpHEGZo6rC2bnVN
	Kph3EKLgj2Hv2vD/mU6udYTyPnthTBhL82FZ/78wQb00Iy1nr/4GmFdq/o5OQjm9FNJuAc
	KoxJtRiPxg9aOwhGEJBejgc0P0BDli8W6nxHcfFmfv77e83zvCFCthtMBxKorA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779982556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/O6690LTogXCGAhOuB5o8py5EPR7dtCvuZauWGkmhI=;
	b=UtxGoMecbSqZhZ5K9/qEXU3v0cDLx8r6WoZoT2gpHWilvg04Tld9rpJnFijViS/oyxTPXa
	nM4k96rOBNStYmDA==
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
Message-ID: <20260528153554.vllN7_T9@linutronix.de>
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
 <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>
 <20260528145124.v9o6OcOc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528145124.v9o6OcOc@linutronix.de>

On 2026-05-28 16:51:24 [+0200], To Waiman Long wrote:
> > The kernel backtrace is produced using the latest v7.1-rc4 kernel. There are
> > a number of changes to the debug_exception_enter() and
> > debug_exception_exit() functions over the years, but the preemption disable
> > code remains since its introduction in v5.3.
> 
> Let me look at this again.

So how do you reproduce this? The calls within debug_exception_enter()/
exit() look harmless or I miss the big thing here.
From your backtrace, you have brk_handler() and this is gone since
commit 31575e11ecf7e ("arm64: debug: split brk64 exception entry") which
is v6.17-rc1. I can use gdb with breakpoint handling.

Sebastian

