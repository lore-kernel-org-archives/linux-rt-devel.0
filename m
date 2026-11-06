Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961693;
	b=icKZEV8OzmVHKWk67LThMQku4Dn93dXfqIh/nofRD1QhlpW/KyS66fBHdcK02//UeVEw
	 pt09a/HCsJDHAFnXH9pxXO1hUgHobTehRC//ih8OW/rJ1U1y0CImb0XC14ciK9426N4+8
	 s2O9yRt603UmDHb5iYnqiC4wVXtmSUCih4fAvDQ8Rr9fiyUe4Swuibw8n2VLql+cXy9hL
	 eudrNwtWxq5Qsm7Y/9h/kvMx8HTsO0yANA+C6KQkovzhMeVachjZwpdPbSjvCAbAjwg+U
	 QkAEtZCiqf5sj9L++Ar3un1iu0S3by4wfCiJnb5uNj7M/dBz0wZVnuCoOwoiYLYY6ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961693;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mt4ngE8OCQ1NU78QoKSBTcQY2l05TpvlxkdsCEV6T7U=;
	b=aXNFVwLo1RPwogXaPFSRl6ovDye8PUQWieSDP6EQKmbrcIe3fsv/wpeNRaTDMtaT5v9e
	 /2KwTI7jC0nZnvt2iWEfZnXez2qRnESJ7woqr9cZOHC7ambgxGtEegVS/Hp3j+OiYbiKh
	 TDZHCfm+3SssR1Vh6n2MZUYV7R+rTJF8jdC5WDEuWkHHSq+XiUFQ/3z8v/DXJplk0O9s6
	 dAZuIc/oLnVg6oR2xlAp47pp7jEN0BIRo9wpBY651qpfXCrNAFs1nDPYKFPCpCsAI8JPP
	 Lv0GwTwTEzj9CbWuGKgLaLMF+OqmIkISgVNZ+ATigGpStzQw2xqccdWMTcU2H2be3SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hGeMKXka;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HEOeJP2K;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A26606A338
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 10:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A26606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hGeMKXka;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HEOeJP2K
Date: Fri, 6 Nov 2026 11:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793961690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mt4ngE8OCQ1NU78QoKSBTcQY2l05TpvlxkdsCEV6T7U=;
	b=hGeMKXka0OBtm2tz66iBJxPrLaj5MDblcJF4UQS5ztt+4Jlg1ypZ+cQgz/LR5YUhHaWrNt
	+46HNDMsgMy1XJ0n0XJsDGT19oGM22syquP9XscGCKBnOpfXQyKCt0Nn+mqO+L6kLp+9ph
	sJUtnvy3DRKtwxkm1hhPDuAq/8PQyZbPkI/uj8Qm6OULPnPqKYQR6xCeNUY2DH8PGX9jrK
	9yxQxn2Ceo1FM1z+4FkQUPlUO23vPdU7BbwjEpoqp3/yCheE+FieAl3mZfck92d4lXvSBN
	KN4/GOjXbMma8kEcENoTDroniwF/klODWvRl/4nmuxBi68TrqiMLgUuG3gW2yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793961690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mt4ngE8OCQ1NU78QoKSBTcQY2l05TpvlxkdsCEV6T7U=;
	b=HEOeJP2K2UixWrnsE3tDqlITmVzZcE8cK14AAFSW2BLbcI/JospmkduD2uJHXQCfGsBlpH
	WzuvtdvUtheSe8AA==
From: 'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To: Mike Schanne <mschanne@kns.com>
Cc: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
	'LKML' <linux-kernel@vger.kernel.org>,
	"'linux-rt-devel@lists.linux.dev'" <linux-rt-devel@lists.linux.dev>,
	'linux-rt-users' <linux-rt-users@vger.kernel.org>,
	'Thomas Gleixner' <tglx@linutronix.de>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	"'chris.packham@alliedtelesis.co.nz'" <chris.packham@alliedtelesis.co.nz>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] Revert "uio: use threaded interrupts"
Message-ID: <20261106104129.N9rFag1w@linutronix.de>
References: <TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY0PR01MB57238A4ACC7B9B3214A00A6CD2772@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>

On 2026-11-05 23:22:17 [+0000], Mike Schanne wrote:
> This reverts commit f8a27dfa4b82d442af1c0645a5acc70cc97c67f6.
> 
> The original solution breaks the threadirqs case including PREEMPT_RT
> Under PREEMPT_RT, it adds an extra kthread per UIO irq,
> which adds a context switch per interrupt.

You need to explain a bit more. I did bring a few items why the patch
was bad and a revert is in order. Let me try this as a commit message:

  This reverts commit f8a27dfa4b82d442af1c0645a5acc70cc97c67f6.

  The patch claims to fix the issue with nested interrupts by using
  request_threaded_irq(). Should an IRQ be nested then __setup_irq() will
  overwrite the primary handler and the submitted uio_interrupt_handler()
  will not be called (only the threaded handler).
  On non-nested interrupts, both handler are installed and work
  properly. In forced threaded environments, such as PREEMPT_RT, it
  results in two threads adding additional overhead.

  Therefore revert the change.

What do you think?

> See:
> https://lore.kernel.org/all/20240326195927.3265297-1-chris.packham@alliedtelesis.co.nz/
> https://github.com/torvalds/linux/commit/f8a27dfa4b82d442af1c0645a5acc70cc97c67f6

The commit can be looked by everyone with a git tree. So the two links
aren't needed. I think a 

  Fixes: f8a27dfa4b82d ("uio: use threaded interrupts")

would be in order.

> Signed-off-by: Michael Schanne <mschanne@kns.com>
> ---

Here, in this space, could please add a revision history of the patch to
the initial posting, and this v2? Something like
  v1: https://lore.kernel.org/all/TY0PR0101MB48676D503A7F6C5CAC112B3BD2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com/
    - Instead of an ifdef revert the cited commit.

>  drivers/uio/uio.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 

Sebastian
