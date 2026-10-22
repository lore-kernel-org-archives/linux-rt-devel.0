Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656110;
	b=Ze0WHodFRzTzB09rMeySP55Y2GVnEXfbryDLB18/Btl/yhtVW3fV5bwEFNz5hF39HWdp
	 VJA3W5dJCNtaoJWyyOYRwMM+7joBhr4Iz/iW7N71nBJmJPrlDQtlcCcCkyHSw/uRb+vKl
	 d26+UOgeKiGHdwkuUZFaR57jKcPNOA27L8GZGtwAaRXEEUnsIDRsfmuwAap+A0Dgu02qM
	 0Iobb2gh2lMlCN/A5P6eTmLcmyIpvtyr04wAUWfzj896lOBHFXqa3N9KnTiUvCbXgMCzz
	 sm/dTLONNdGNMLtDGPKpwsbGnI1GmBzHP+FWq1cJVriedAw77p4TfJHiF4XvOWrvHMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656110;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=JbKFAr41V/OefXlmjM+nWV2fMqRtTVj2bBoruezpLiI=;
	b=4LeTMCQ9XXm0PZKf0n25myNvyLdhphHt+jWPYY1JI9y7vd8tbX1V0oPeXpItdLgH3jLl
	 v9hDr14hxa7UhNIOcfrvtVPrLnj5hD1zKwmpFaIRqpPazt9ufo+c7+6DOfj1v/zfIq5HC
	 2wskDkYejub0XE+LlJPDsUIHAr+ApbNoU+g9vowoK83LHaW9ImzW9du9xxY3oi19bhdas
	 6v+Ahr+pP1tDZo/lBDGy4Bo/659ncvq0meE8X+CxBIuyWZjUol4yuPQqWeHxg6yt1cDc2
	 8hAA42qm1kSR69g8GRn/uv1wWKlFsmq0Ij/XrGmRRLcGnryXOUonFRGOifR4xmG0Vbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=M4qnRhbA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cqyDP2xD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D06606A319
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 08:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D06606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=M4qnRhbA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cqyDP2xD
Date: Thu, 22 Oct 2026 10:01:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792656106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JbKFAr41V/OefXlmjM+nWV2fMqRtTVj2bBoruezpLiI=;
	b=M4qnRhbAk2Odk3LppREAAt4j5eqTDeHRAgmDzS+oBxYUUm49hoEWBlUKCLqMdEiRjs6zuK
	wTiKNFluCQrRLd3T3Pe0VkumkCWOfXtfzsdBKB+WVIA+GIlFFg+nIkOanNhFT66Iedt7ts
	1q181AaJLzulRk/EhyivVSQ/9JJTOxrbAc3TP52o8TxhgVwVlM5T4e7tFjeDUDY374WKnu
	QFuhhqv0DNiU9hA0qIiIXWtwJbOue4p3cADCq3yCdV5UZcOMK0nO1KdP43VfWM2trGSqcx
	pwIXOZafR8/KaSpUREcNuP6J8ZaRYTr90rC/4wLDw0Sks9rN/1pMR69mMfz33Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792656106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JbKFAr41V/OefXlmjM+nWV2fMqRtTVj2bBoruezpLiI=;
	b=cqyDP2xDa8uae4qJoVovWxroTINKtD6apdqaWwosZYU3Mz/Ertba7pbUAcy4VrDp0fi8X+
	fSDX7oHdB0WZpHCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <20261022080145.NcnnXP0t@linutronix.de>
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius>
 <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
 <atZWIBciePyeMnWa@demetrius>
 <atZmgh0uq6sTdWTc@demetrius>
 <7f5046fd-f38e-4966-a616-0c8d95833eed@linux.dev>
 <atkgWnLibc_213ES@demetrius>
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
In-Reply-To: <atkgWnLibc_213ES@demetrius>

On 2026-10-21 15:28:10 [-0500], Clark Williams wrote:
> I've applied your 15 patch series and built/smoke-tested it. I'll wait
> for Sebastian to comment and then I'll push what I have up to
> v6.1-rt-next.

The v6.6 bits look good. I browsed over the tree and the applied patches
lack your SOB.

Let me check the v6.1 one.

> Clark

Sebastian
