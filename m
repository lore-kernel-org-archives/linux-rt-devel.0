Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20953C1FCF
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991966; cv=none; b=kNpP1CSeN4TL5FM9tyQQEokd1eTZKOkcbdERgGPsfKOaQAgpcenAoWseEWuGVmFWSrQnwJwAtn152m8rGdw7CcqdRUY9xhd+k9w25NpMauv0OY3XSm/KjTpRwSxobS9SJKjm6lkThYe4Zl5z129UqnTMf9J6I7ddSLvUdpAAaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991966; c=relaxed/simple;
	bh=jymXLVHEkgdyRKn3Hl2HM6yd+3JEQbrLoMZm0zjo7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzgbHcsUJBE2JQ8Phggfem/0ORxOvWizJjEnjLLiRdOJ3u6qK+3pPIj+1LKuDGhuE1/R84t0IncWaQzj8FmmCoCfiJTwbuJVuFo2DQN3QtMYs8Kr5mkUW+NmCBwQFQ3tOrDb+S3ewtsMD1q5Dhn7f/jg19jbHZIs78+gi79plVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMnx02Z5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJlrt+gO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMnx02Z5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJlrt+gO"
Date: Wed, 21 Jan 2026 11:39:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768991962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LuScnkTRBXXAwIA4U4HYbmGJQye4khtaiAYe5oV0p6o=;
	b=gMnx02Z58ThkRv3eA+BrfCcMv9QBQPvFX4K7ToswAovbQ355uw1CwypkN77v3r0KvgTwMm
	TZmPcmZ4bKfWCGKvfIul48PSTEHzRKw5klz6SX++QvdZ5yiaOlBHKsDnyu3zrLSnpeZp0o
	SRl0aKB5jZnOplgXhmGAS6LmbSn15a5RsXC1aGC+fAMoEqfDUbWJPd8F+niH87VtMOXL6V
	RqIhiMSC0Ux+5fR/AI3oFJf4k0kcY2U7S5kcTo6mH1Peep9uOCNtIjOfDzG2Totp9OBNNO
	jIn+PeV6LEKVOdUr8NpJX0nImUA8N7Fqsf0RvRGiPQWJlmL99pg3Uqd+Jc5t4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768991962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LuScnkTRBXXAwIA4U4HYbmGJQye4khtaiAYe5oV0p6o=;
	b=HJlrt+gO7iq91Ckn0ORVvTw1fL8FlhmlVRDxE2RdCbZ5kKlT77AObykEn5hCzQeDGdMVOM
	IO+Njc/HN0Im3LAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hans de Goede <hansg@kernel.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	sfr@canb.auug.org.au, ilpo.jarvinen@linux.intel.com,
	regressions@leemhuis.info
Subject: Re: REGRESSION on linux-next (next-20260115)
Message-ID: <20260121103921.q-r7pAzL@linutronix.de>
References: <555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com>
 <20260121075348.5MyqcHFB@linutronix.de>
 <89de03a5-e5da-4d2e-8547-8e54ad73b324@intel.com>
 <20260121090154.Lpaj9hrr@linutronix.de>
 <1a68f6d5-6541-4b04-8628-397001cb1e55@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a68f6d5-6541-4b04-8628-397001cb1e55@kernel.org>

On 2026-01-21 11:20:53 [+0100], Hans de Goede wrote:
> Hi,
Hi,

> Right, so as the commit message of commit 8f812373d195 ("platform/x86: intel:
> int0002_vgpio: Pass IRQF_ONESHOT to request_irq()") explains
> the int0002_vgpio driver *must* use the same flags to request
> the IRQ as the ACPI core does, which is why it passes IRQF_ONESHOT
> even though it does not have a threaded handler.
> 
> This worked fine until commit aef30c8d569c ("genirq: Warn about using
> IRQF_ONESHOT without a threaded handler") as Chaitanya's bisect
> pointed out.

Avoiding forced-threading on the int0002_vgpio handler is actually a
problem on PREEMPT_RT. But yeah no complains from the stack.

> Sebastian as I agree that switching to IRQF_COND_ONESHOT on
> the int0002_vgpio.c side is a good way to fix this.
> 
> But If I'm reading your proposed changes correct then your suggestion
> is to drop IRQF_ONESHOT from int0002_vgpio.c and then instead of
> replacing it with IRQF_COND_ONESHOT you want to always pass
> IRQF_COND_ONESHOT when using the non-threaded request_irq functions?

Correct.

> I'm not objecting against this, just making sure I understand
> correctly.
> 
> Note in that case you should also add this to the non devm_
> prefixed version.

You mean request_irq() as it has been done in commit
   c37927a203fa2 ("genirq: Set IRQF_COND_ONESHOT in request_irq()")

or did I miss yet another wrapper?

> Regards,
> 
> Hans

Sebastian
