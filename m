Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D734D931
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818181; cv=none; b=ARwrep4JqoUt/kO+OgATL8K6y/nTGD92g3nEaZGY7KNdTmTA3bSSbxCIWGL1vg0WtU8z/y4ucjXW//4Z6ahj8Ze6mftRRaG2gvLWxGT20wyaVYu0ClbJ1nnRfn/TMidkETL17euOaCAYZTPAMxBqOxu3DHdMzQKldcTNkZMORrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818181; c=relaxed/simple;
	bh=TzaNIZ/M0C1S5XKgPFxOq/lpxDfAIR7VxBQ2u309oIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auqkNbRYNHwudgttwVIlCvphJUUaEE3pJF9K+vBW2lSgnQOmKvH7DaK/k/Wqe/RXtdHKkcdijkWehO0xdmYmZX/5D5kc2HVg5+9iuKDhDQ4Q6RWxGxmeZTnVkkBiTi/+mnvHm5h77RsyiZ5cEA3JwkREscBfcXXkzfVe2aYby1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2RJT8VxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lY2xibEs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2RJT8VxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lY2xibEs"
Date: Thu, 30 Oct 2025 10:56:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761818176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPr3C8MPAG0KuWxSSS7iUR1OVZK1Y00np5V5F5knBiI=;
	b=2RJT8VxYwMSo4k+Yh5D26jbLB9gwIoIKFJ+SPes0NxkcrU9atRcM+MjbMQpA0Fxp3VN1qb
	XsOh0cxBd4KDVR7HE8U1ylCzdce6tA8VzKn7YtyyxA4LVxyTI3al+q8C/1O46duS7nMye7
	tBUPxKAfXQAUz3g3br7cMoWxN16XHV1kpRwE4aa1Ml22CcWBEbQSCjFSoAqSQEMtjjmBTp
	B5aLfEdm8ljk1UJ3cjCQNCxmkT4uR8NngGyar1xxjwGPWG3KZ7S3K/rBrIEVjx7DiG+t+j
	OhAMI0/VItQuI1Q3n6p+SWnUKIgNqpNRZcEe/NkKyi7FAJCH5JOwXaJQMWlVng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761818176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPr3C8MPAG0KuWxSSS7iUR1OVZK1Y00np5V5F5knBiI=;
	b=lY2xibEsqFq2SKol75sefz3hqNB0vVoec3X+AGGU8q8+1r4knzPfmmBkfiNsxen1sXbjzs
	Uroc34JPUgcGtQAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, linux@armlinux.org.uk,
	tglx@linutronix.de
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030095615.ae7bck5m@linutronix.de>
References: <20251030072339.63vdFNo3@linutronix.de>
 <20251030074507.33863-1-xieyuanbin1@huawei.com>
 <20251030075558.sUBj8_6U@linutronix.de>
 <20251030054626.7a897b29@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030054626.7a897b29@gandalf.local.home>

On 2025-10-30 05:46:26 [-0400], Steven Rostedt wrote:
> On Thu, 30 Oct 2025 08:55:58 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > You can't really control when jump labels are enabled/ disabled. For
> > instance this happens if you enable/ disable trace points.
> > Arm64 and X86 replaced the stop_machine() logic with something else that
> > does not affect latency in that magnitude. If Arm could something
> > similar then fine but until then I don't see a way around it.
> > There are other things that are disabled on PREEMPT_RT due to latency
> > reasons such as transparent huge pages or expedited RCU.
> 
> But transparent huge pages and expedited RCU are not user controlled events.
> 
> Enabling function tracing was known to cause huge latency for a very long
> time and it came from the PREEMPT_RT patch set. Heck, printk use to as well ;-)

trace events were an example and this is used to enable tracing in
production or development to gather information if something is not
working right _or_ on the edge to investigate. A latency spike at this
point would be a timing violation forcing the system into a safe state
an so not allowing further investigations.

I hope I made it clear that using jump-labels at this point is not
doable at this point and a warning does not improve things. Improving
the implementation on ARM as it has been done on ARM64 or X86 is how I
would compare the situation to printk. Not adding a warning at boot
time.

> -- Steve

Sebastian
