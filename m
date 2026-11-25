Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624959;
	b=U9bqOmkBUuQl4NY7oBGyQ4MxxysbEgIJWD+VMgmXY9lJioGYPQ+jwMIXQAYDlSo5KTpX
	 YhfGi9VpSR9D0benSrIMr/G/ejTHt7XrHFoOlhKZ/oxO8ZX6I7wUwxZhNkAyagh+5NDyB
	 BXjbUJArii/AB9PaETVcIWfzpwxlxaGxNLP+fjdZOESzB3lB0G9ucgpdFJbHydc3XhPBy
	 Imc8+aebPfL0ojxZen/oEAIGgGjb1FSR4fk9VmX8k/cf3qRah3n1IxxEaWveGC8VwF9cG
	 qvTB2ktSG5ITJKhnOuIt1S5jD2b7VEgQK7mFyFhhHFl1FmkNtHgnmjXNNDnnyb8xAZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624959;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EHgEByfTZPaLp2bw6wpy8vSvwTawwfqiRjn3iLBP4xk=;
	b=rSZfA4rb8bad8kbdl0jOUJ8Cj5Lhupce/S0A3y3VRFKkc2IB2fIGZcGEPdahDJhAYlCY
	 Zl5gFCdmH/Xmli4+zDExOAnIi2gPvGdG54O55u1pL0rGNoxjK9WucNTNIP7JH1XPBsQTS
	 UkrdLzhYAja5bPjXbAbQoTX/ria/L/Jdg5XJYYB33z6xCawAe1ch62ARM4nlmRkdV4Wqa
	 sf+OTDcSaRyFZjiI1xRMppKsDps7TjXdiNaGxfC4X6Im4/UGR7/L/3pliy7D/4PCOfw5s
	 BkDvhJyr6iGEqFulUIKPQn6b4WO2xg7kaN5JZv/82Mx7UDjU6H3GF+uOH89gzo+6I9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="ImwW/FRR";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wa0GIV9x;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23A606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD23A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ImwW/FRR;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wa0GIV9x
Date: Wed, 25 Nov 2026 17:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795624955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHgEByfTZPaLp2bw6wpy8vSvwTawwfqiRjn3iLBP4xk=;
	b=ImwW/FRRxRdEoCzsAQmL5MCTzkfks7zDWI4KUqdQ9JJxq7O+zCnaE0MDS2dQuIF9mJCCep
	uSXDLJrMtMsy98EDURurHN9XekxuthAlb01gsBg5wKYy/APn9kAVEjxEYXzSW22JHBLRUp
	O0XlZ9Lus8Z9W9kd+Ww3YV8bLQfK/dadFOrd6XRJAAG4wNv4IF6vgqXgFR9nzZFerJFSCd
	d9ktkRnk9iOSL7SCs+cDhDEIToinvZQn+Fpdcr+GIbYvyH17K1H6U6w//C8ob51Kri6mQ0
	DeEkLZomgvBzaD7xulnIHCW7wFxOSdQqR/PrHXKGCRM6UCx4XTMh+rPRz9QCcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795624955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHgEByfTZPaLp2bw6wpy8vSvwTawwfqiRjn3iLBP4xk=;
	b=wa0GIV9xoMOONcoL20t/lY28TX5uqB2Uv4aXuH1m7x/wCNE4ckNhfcchKEd+SmmkpKuywf
	AX8DOSQL+Ps6YPDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Schanne <mschanne@kns.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH v3] Revert "uio: use threaded interrupts"
Message-ID: <20261125164234.ZcjCigya@linutronix.de>
References: <TY0PR01MB5723E978A7EE94644B15621FD2782@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
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
In-Reply-To: <TY0PR01MB5723E978A7EE94644B15621FD2782@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>

On 2026-11-20 20:21:15 [+0000], Mike Schanne wrote:
> This reverts commit f8a27dfa4b82d442af1c0645a5acc70cc97c67f6.
> 
> The patch claims to fix the issue with nested interrupts by using
> request_threaded_irq(). Should an IRQ be nested, then __setup_irq() will
> overwrite the primary handler, and the submitted uio_interrupt_handler()
> will not be called (only the threaded handler).
> On non-nested interrupts, both handlers are installed and work
> properly. In forced threaded environments, such as PREEMPT_RT, it
> results in two threads, adding additional overhead.
> 
> Therefore revert the change.
> 
> Fixes: f8a27dfa4b82d ("uio: use threaded interrupts")
> 
> Signed-off-by: Michael Schanne <mschanne@kns.com>

Your mail client and or server replaced TABs with SPACEs which is
probably the sole reason why it did not apply here. Also the trailer was
there.
I mostly redid it, kept your commit message, used "Michael" in From and
your Sign-off-by line so it is consistent. Hope that was in your mind.

I reposted it as v4 and should it be applied you will remain the author.

Sebastian
