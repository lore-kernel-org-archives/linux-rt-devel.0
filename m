Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3571FBEBF;
	Mon,  2 Dec 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135556; cv=none; b=PuIRnEHMz6+2GAK+Arc5X26uJsSZ4mkdD/Sk6ZPTElrDtLbE8YEKtnkTrqNJuPVv5Vdv/Nsv8AvS6nFXFnNAnoUcRL4KmlH7OXR1Yi5TCJ6eI8MIXPuwo9lTloEts6cFE1qKssOFrfbyJ3Pf3zqP95g0skTh0W2n/lgDusJWnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135556; c=relaxed/simple;
	bh=dD645igug4uryAPx8B/NRmPRm55kZrdgIULlD+0sH1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzhLbm/jkss1wmxXaRmQHkI/nrX4BhvD8NAs1C3JRlgzrMzkxqik5Cm5k33VDQSoz5/DoGQdQkHUVXCRZ92GWxHhQqMfu7f2XCcUGFEzt33UGr8Ohrv5qR1AcpLD8zodi2Mvt3S4ePZSSi2b+1jEJUH6iVwyXP5eR+gWkVaewWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olk2X7ew; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olk2X7ew"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=on5sNrP3KPtOdYBKItycuNBCOZl1eJmmYtIIXgoX864=; b=olk2X7ewWuo9EJUoxTt3F5YPoV
	7iNS39NNH/a9XO4FHIBliQ7qHboi+OlLTiMzbkrz9jgOYEoe0feMfiX6Ogtq24VkMaKg5p0Q8flu3
	IBB92oAYpSstt4z3oyiKVl14z6/iBZ170OsdCEXD/SDtglDOjMhVUWjjHMQ1A2ckqXaxYtBLI/c+1
	Q3+hS9jPTZ3vqOD5Ct/llxIdPGlGE3gTkVJHUFadXRyC9oPCLcdgbm/pd85dEcZ1I+S/w9xIJqIqO
	IJOyZz8StvB3Bkd/e7PMx0sq/C10eG5sIIBeV71PIUsxLDlWpTOk5a4jXSJCsKQyfCu0rXq2/6Wt+
	EtYAOR+g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3jB-000000029Zc-2Nt7;
	Mon, 02 Dec 2024 10:32:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E87D430020F; Mon,  2 Dec 2024 11:32:28 +0100 (CET)
Date: Mon, 2 Dec 2024 11:32:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <20241202103228.GM24400@noisy.programming.kicks-ass.net>
References: <20241202012017.14910-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202012017.14910-1-ryotkkr98@gmail.com>

On Mon, Dec 02, 2024 at 10:20:17AM +0900, Ryo Takakura wrote:
> Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
> to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
> as the report accounts softirq context which PREEMPT_RT doesn't
> have to.
> 
> However, wait context check still needs to report mutex usage
> within softirq, even when its threaded on PREEMPT_RT. The check
> is failing to report the usage as task_wait_context() checks if
> its in softirq by referencing @softirq_context, ending up not 
> assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
> softirq.
> 
> [    0.184549]   | wait context tests |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184549]                                  | rcu  | raw  | spin |mutex |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> 
> Account softirq context but only when !PREEMPT_RT so that
> task_wait_context() returns LD_WAIT_CONFIG as intended.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> 
> 
> ---
> 
> Hi! 
> 
> I wasn't able come up with a way to fix the wait context test while 
> keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
> on PREEMPT_RT.") without referencing @softirq_context...
> Hoping to get a feedback on it!
> 
> Also I wonder if the test can be skipped as I believe its taken care 
> by spinlock wait context test since the PREEMPT_RT's softirq context is 
> protected by local_lock which is mapped to rt_spinlock.

Right,.. so I remember talking about this with Boqun, and I think we
were going to 'fix' the test, but I can't quite remember.

Perhaps adding the local_lock to SOFTIRQ_ENTER?
