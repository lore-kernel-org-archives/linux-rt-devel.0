Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB569231A30
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196422; cv=none; b=CqVeMxbU2yCxKlYmplfxLaHXVE4skqPEWLpsO+jn5RkHLaXokIuzU9Ql+CUOH4nhJL7J3pP4vcjxyXE1CtAo5KmAYy5Yc6vvxDIDkMIq/94nQuGp7wuHiREbFw/MA6CtjO27VhnewSiqi0iVS9mQRqSC+FTScJ97o590Tuk5MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196422; c=relaxed/simple;
	bh=UDIjAUyOFuxtAlTi618t22rHv0pgRZ00SzI1HZfuZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIHplylBKqQrEUowJXLo0AbNgWTvOcZBuL5mf3DPNtgrnMkrNawz7EDv5UsmMGCZZ6jNyB0GRlsEn2/Sdt7ynwDMrNrCypeZaThz0yd6GJmd4UG+Do65kLqxrAnGBDvkAHltdMJjLADYpAmhdFLne/OwiB/vdjWFfTxBwAip6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdx36Gck; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L19kvCZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdx36Gck";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L19kvCZd"
Date: Mon, 10 Feb 2025 15:06:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739196418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78y7SNdwac/iLbnDAq+m4G4JXWRhEfokglNJz+Kj4VQ=;
	b=cdx36GckXXGFn7nRaOep+uZQFTSO0o3qmTncullx96eu3S9siqVyjGCXH2MIL8sh3c8yy7
	ql4c1f2+TgCeTxF0FehWNoCu62yQdF8I2tugwonCedecBNFhdAAeWwWLh7TcU/5F/g9722
	L78yEy47Md+zTG2gxtPtU4foaMEl094d6ozYgta2sWWGNeHez7kQa8Qh3horv2JrqP8M+w
	rBrZJIp2Fq2KkHYIDmprpZB6ETPFVC90S2hLq9YFlpUszJQpVtgOIquqJtQef8QZzLLqI9
	Ftur0nFSTt4spjiJ3fCELLijLMrZ8S+0skkfd5IXsXK8M8CR4459Y394PnBvTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739196418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78y7SNdwac/iLbnDAq+m4G4JXWRhEfokglNJz+Kj4VQ=;
	b=L19kvCZd/HaCid0Ds4t5TJ2Bcga4AyQ2zAP+XiB4Ejdq0jO1SEkmsgqCEq6m5CFwK/8qVH
	Ph+jh3v6JoS0rtCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <20250210140657.UAsRw4k8@linutronix.de>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6n16cK85JMyowDq@J2N7QTR9R3>

On 2025-02-10 12:49:45 [+0000], Mark Rutland wrote:
> Hi,
Hi,

> I don't have an immediate suggestion; I'll need to go think about this
> for a bit. Unfortunatealy, there are several nested cans of worms here.
> :/
> 
> In theory, we can go split out the EL0 "debug exceptions" into separate
> handlers, and wouldn't generally need to disable preemption for things
> like BRK or single-step.
> 
> However, it's not immediately clear to me how we could handle
> watchpoints or breakpoints, since for those preemption/interruption
> could change the HW state under our feet, and we rely on single-step to
> skip past the watchpoint/breakpoint after it is handled.

Couldn't you delay sending signals until after the preempt-disable
section? 

> That, and last I looked reworking this we'd need to do a larger rework
> to split out those "debug exceptions" because of that way that currently
> bounces through the fault handling ligic in arch/arm64/mm/.
>
> Mark.

Sebastian
