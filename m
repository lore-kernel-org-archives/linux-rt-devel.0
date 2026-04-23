Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B51378D71
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938791; cv=none; b=omZVdZi9q4sD7iaLCvGVR/siZkP1HNXFN4o/zoAeQFZDdMFUJiwCQLMJrZ+hSRZ33z3SitTMeAk8lIZjhi1BNNAAYRH4EaQXsM2ok6maMi8Sienii5pC0588EDoHJcasdQythfO6WNeMkGOUC8FwGzSjrTwifeMBOIWyD9kycRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938791; c=relaxed/simple;
	bh=wCg3ppKt8D0iRsO11SW68vqC+dd9jVyva2LM6R84rI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg2SrNQXhMaPCU14f0D57aDLyT4nWFItJitQVx1EeNcYphWLhkkWDszGDWL4M6YRIRYMOe2AZbjUOxlFPHHHOlYKup4buxpNfTrf8Q0nlStwK+TDtW5zW+vVNflOW8NJsBHUp9NOP4EP1QHbW49J0toz2tRm/zvYXlHxL4/NBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDpYCx3M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OI8YhRII; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDpYCx3M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OI8YhRII"
Date: Thu, 23 Apr 2026 12:06:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776938788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDuqNyrmgg5xRrb81O7Zm3JUXxPACJI5z4OhdpBkkGM=;
	b=xDpYCx3MsfY211KlrybTCXLrPBMxBQz6ZaauQKQ4q9lkOemswte0mrvaeskf5zzuvOkooe
	UZhnkD4WDbWW/z/q8/s9m4JOQ6a7stA8rx2rxAj+67ZtgBAMmrG0Ng9P5DW99ZjES4KRF5
	BhHadhJ6KHl7/oMAmD2OwqwDqRHchnGeENqrFIMRiwTnxXpTQvHlyZU2PiMtylxEHnHUP3
	DdnIdnl/eEHq7BzoVE+wCNYThuy9npt3icnkW+nSrzTwCuwIsMSttKCgtnRGX+cCJ2Rttn
	4ceZEkaQY0Z1BDOemTzu9xOtKANQgqpmfoBhQRLWhlU6M8bF8dXEK79CbmgEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776938788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDuqNyrmgg5xRrb81O7Zm3JUXxPACJI5z4OhdpBkkGM=;
	b=OI8YhRIIwMgU1uUmnRqAZcWbfBo1WMy/avn7FUsndB7Ua95G8UDIkGIZ+sBnJehJUXXFpY
	KEGpQ8ioBR57mqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AW: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Message-ID: <20260423100627.O634mccg@linutronix.de>
References: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
 <20260323133034.vk87xPj9@linutronix.de>
 <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>

On 2026-03-23 16:12:24 [+0000], Moritz KLAMMLER (FERCHAU) wrote:
> Thanks for your quick and helpful response, Sebastian.
> 
> We have tried your patch and it indeed seems to solve the problem (using
> the example program from my previous message as a test case).  It also
> certainly is more elegant than any of the other options we've considered
> so far.  Thank you very much.  I'll report back if our system test
> should find any unexpected regression in the following days.

Ping.

Sebastian
