Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685813A3F7;
	Sun,  5 Jul 2026 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213574; cv=none; b=X/WZ3Kl/Vpx9cm7w1uC2bXMkOolVljXdcWTbNG2HGFMbxl8CLPagFwBQkHZLc7e5tPbet0Rit+IIbpOVfy040+u8Q/MmVxr0EUh0okwVsofrEEfPoSFOVpadmHggCdWZdhvMHUiA0xA3CXrcpOEbv866P2v/UL3FTK78AjMHJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213574; c=relaxed/simple;
	bh=q3P4U4nKPKnQeDEGJEM8BsOP6yrOs+if7vZ3vvCi48E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=flJBr8uDPOhBdOaSLl404jirHWSbJ/prXTRWywY1kJwINHf3m4X4J/WQBCumuPP3qkRke9gR1PMg2iArAPcrljfp1yQS4pPbvAk16TkvaYutpwwCrqyypb9Fvo6hmMolAnz+aJskmqIMQ3PQVxl34ZLS5vdUalYkcHdbHXT0PFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KFRAv1Ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KFRAv1Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C907B1F000E9;
	Sun,  5 Jul 2026 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783213572;
	bh=ft3r6NFcOCb3kuo8w3s9c+oIeiqaP3U/+EY0XOtwKdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KFRAv1Ig6Of8BNawkkN9VraBMiC9hBDjFDfTW6HpiHCiWZivUaA7a9wnMhxuRKpm4
	 Ydt8EILndaoE2G7VkjvLNg4fY9XMT10A+coB5s7aJDDnbowwSYf06asWsWr3fXA0dQ
	 QMhVHGrVRNxYcDS+y08p9yX5KjzhgjcYrHL5Z9GE=
Date: Sat, 4 Jul 2026 18:06:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Rodolfo
 Giometti <giometti@enneenne.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eliav Farber <farbere@amazon.com>, Michael
 Byczkowski <by@by-online.de>, Ingo Molnar <mingo@kernel.org>, David Laight
 <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Message-Id: <20260704180611.8898a9e290016d2dda70f6ae@linux-foundation.org>
In-Reply-To: <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
References: <cover.1780359378.git.calvin@wbinvd.org>
	<2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 17:44:09 -0700 Calvin Owens <calvin@wbinvd.org> wrote:

> Split the pps-gpio interrupt handler into a primary (hardirq) handler
> that captures the PPS timestamp at interrupt entry, and a threaded
> handler that processes the event. This produces the same two-part
> handler structure on both PREEMPT_RT and non-RT kernels.
> 
> On non-RT kernels the threaded portion runs immediately after the
> primary, with no behavioral change compared to the previous
> single-handler implementation.
> 
> On PREEMPT_RT, where interrupt handlers are force-threaded by default,
> the previous single-handler implementation captured the timestamp
> inside the threaded portion, after IRQ-thread scheduling delay. With
> the split, the timestamp is captured in true hardirq context as it is
> on non-RT kernels, eliminating a significant source of PPS jitter on
> RT systems.

Thanks, I'll add this to mm.git's mm-nonmm-unstable branch.  This means
it will get linux-next exposure immediately.

All being well, I'll later move this into the non-rebasing
mm-nonmm-stable branch with the intent to upstream it in the next merge
window.

Sashiko AI review might have found some issues, one of them
pre-existing.  Please check it out:

	https://sashiko.dev/#/patchset/2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org

