Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1424A061
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775035; cv=none; b=XmetL0+GMUXA8flOhijztPF+2QJyizPMn6u3dRKJjmhOyVnOs55Nc+i8MzG/lruDKQfbkLLkndRXm24KM/8Bnwde3NOiCZLEXoIPcmPuPCBvLDZ+i7EA4EM8kq2K5TAMuQvg/Bp27DvZPdp+UneLHe6zRCQBi2c0+y7Kh9n6Llg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775035; c=relaxed/simple;
	bh=2BUfcgCrJNd4CKMKzefVZR+8SKV18VIfH+NHbCQsXS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NodHlrwSnO0uC3GFgDCK9psmFwJiSHN3AnuZau0RSw0hm5WktPk8u5aixMJIDUfVH9OB4KEYbQ1khP4+OmTwC0q9kbgk/sA/vD+4oJeZCxjlBFpca0HycBmDib1AgMj4E2xwrQjKacx+Cvz5fmeFsIfzuyh1ynsJzqzk5UEicTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ki3e8wtC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Ox1q9up; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ki3e8wtC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Ox1q9up"
Date: Tue, 24 Jun 2025 16:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750775032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrpSBL/DLIzI8Jp1GABlBZa1QLU8cOGFC43YvRyDTwg=;
	b=ki3e8wtCd9SJ7t9BIbk/33RI2H3L4u1EgoQsMqDtqMTIucEh+FwvCt6HLpzmcgpfiQk2LK
	9ZIWfpRTRuthrnt+vbLsy9Bm8osVRcZ0sKoVpCiN2+o0gCrwELuoU2JwEgQEx/LOxXbTSd
	b9f+NTbWKejtUmZVGDhIV7Dkw9MbMlwPCFISMIvS/k5ErRAHRN3q1yT1EPYWVqa3M7rUTX
	qnrtAVkJeMkr88US/gVcQb2bq4tGi45elRV+1UrugGKc+OeBDiDwCs01YwKw/JBjkG1fNV
	0wyUbsTRfFDhlwQUZewhAT9FNC4SkCyzdD5A9/0pa5zxYKSs0bJYk4+z1zCsNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750775032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrpSBL/DLIzI8Jp1GABlBZa1QLU8cOGFC43YvRyDTwg=;
	b=+Ox1q9upvHIs+HqG0mecMSWkZTr4CpN8Ir6qcIVFg6RmjyCmJcl5BucqBcplFnhDne/GxY
	/krpYf0/y4Tu7cCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624142350.xZ_DdClH@linutronix.de>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
 <20250624141130.gZVv4WnP@linutronix.de>
 <20250624141801.GV1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624141801.GV1613200@noisy.programming.kicks-ass.net>

On 2025-06-24 16:18:01 [+0200], Peter Zijlstra wrote:
> I'm confused, sending signals is for exception from userspace. That has
> nothing to do with exceptions from kernelspace being NMI like.

Yes. See the original submission
	https://lore.kernel.org/linux-riscv/20250620114346.1740512-1-namcao@linutronix.de/

Sebastian
