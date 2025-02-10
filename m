Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3B1CAA88
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185193; cv=none; b=qDgRuVRBYr1ackoI42GzfJjzmVTSytQoJ6pCTWpRdRPidHgu4ZY8Prn7vIeBbH4L9L82CxxWmZcCgBoj43QnrsQWjBgGWVZF7c8O58QF2gALqVx9ieeoq8UtvJPm/CVUtotgJ6IOeAbOvemd1SswdBakNzc31ERaFxjxmWWriyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185193; c=relaxed/simple;
	bh=qxq0WC8B3Vc2yS3DcNSsysCaxaPDfFdy0Oz7wZJ9JV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRk7y94ciBm4Uozc9WppXk67rqhSbxP3F7wtONL71XLWoVlsVC1JVcoBt8xmb4EE4JtVKxneMzjRV+xqPQaL449QAiZv6aXfhVU8RWz4fZm3+J+/SvEVJyHGYd3qnzPLiwZQyyvk3h8E9QAxWlLNhnSmXE/GMIvD2iqYtV4xNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzmIUaI8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/PoQOLr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzmIUaI8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/PoQOLr"
Date: Mon, 10 Feb 2025 11:59:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739185190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/71EfjX9I1EgSNmijPvfd/2Dexoeg3yU8p5Lg2VgJU=;
	b=EzmIUaI8e9kINUayIQcwRp9+MXEH03GkblyBVp838/g5Afftv4Q7098EEAKnegCn31DaHY
	GEqCNwlPYYVOmGK5SmmajhhQqzOVUJ+3UsaEiiFEFAZZ/tSnOszMxBwuLOCwtO6ZVlmqDa
	UjXjB1km6CYLIXauECZO11b20EUPyilT4FoHA+PCqYMfreI5f/ZoKmOpNOKaizKJmJbrYR
	JEdzMqPoH3cxqs3N8Oznu/OcTbkoljftoNPiP4hI9qjg+2ZZ0CukkvOd50gr8lE8jV4UNj
	gdXGqtosVV1pC47eH2hkKXM1Hi65w1W3T/RHkBebziGdFlopLAAM27LOTfK+3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739185190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/71EfjX9I1EgSNmijPvfd/2Dexoeg3yU8p5Lg2VgJU=;
	b=p/PoQOLrVzaTKUuwfSrgtlQGN0h1g9uTAdLZYP7Tj3VncGQDDUicCpE/5BXGgKk1BiSGPT
	QtRCE73gAFwRdNAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
Message-ID: <20250210105949.b9PKqiw7@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
 <20250203160103.9DikC9FJ@linutronix.de>
 <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
 <20250204082223.6iNyq_KR@linutronix.de>
 <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>

On 2025-02-08 13:05:57 [+0530], Shrikanth Hegde wrote:
> 
> 
> On 2/4/25 13:52, Sebastian Andrzej Siewior wrote:
> > Use preempt_model_str() instead of manually conducting the preemption
> > model. Use pr_emerg() instead of printk() to pass a loglevel.
> 
> even on powerpc, i see __die ends up calling show_regs_print_info().
> Why print it twice?

Thank you for noticing. I did remove it on other architectures, I
somehow missed it here. Will remove it from from the arch code.

Sebastian
