Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EA281530
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615669; cv=none; b=eJ21SVZJ24hnOa8XvjjNqhRHzXtPDaz9fR2Ah3MKEk4Q5bfR3yAIUq+ZHsaFD3TFQxpK9IC2ZNHvmhLxt6PIEVQogU/RRGSqUZnjZF5nRb62ubZKQ4nBVGiUrEJG3AueI83/LOuKgxdvHGHKWy3HWT5YvFErXWapWgZYCZlG5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615669; c=relaxed/simple;
	bh=jGEY3EnOBXun4SQ0ll/o32z1qo0qZY8iGqdHqyf5ANY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVtKiDfNvmgayLBYOKWGLaekeO8WIwRfSEyJALGJRjCRLI0jdjT3aUwn+IKGKecd0qD8ClhJLXS7faTSgPsXT2eDXGATID/SKGUQkFP0bnggPb3XWKBKErYlnrHrvmCy+0xXOM/e1YoaezXc3Bw+2IeVC3lrSZ3NULguB8oznRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzapx1AA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RhmkHGfQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzapx1AA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RhmkHGfQ"
Date: Tue, 19 Aug 2025 17:01:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hYf3QFb0JiRzAbtPuQzxzkHoV2M9phfTa2ZdhDggos=;
	b=kzapx1AAcR/HPJ39aWX+tVOWN6MnRU0okwgYpB21DR6ZE9pZORJX/aiCWQrvv4VhCzVp0c
	3wbDbXBpUw6Nj/OcMHieNLshKeiaUV2F17tgJVdO4RoC9vce/OU+0bOMo/Z5t6XLx8BUTQ
	J0mnP/7PIeLrOxRjmnnsJv9FcHQ8g7pkFa+8+2hGuX8+D4ZHAuYYomfsKyzxac1RDqX9t9
	bfMarcltQ3kIlkC+miaJdHR+ji2UAG3YX4MBrDB2bA/VVIqgo6kfJk7tF5yI6Pg+mCmuU3
	Hvb+Mmg5XgE4YrI7WfdQaYdSzG5jPa4jlK5IM3jMWbLnW+KaorYsazSYpgG+hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755615666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hYf3QFb0JiRzAbtPuQzxzkHoV2M9phfTa2ZdhDggos=;
	b=RhmkHGfQPxVDamkMwkJHH0HrCo+psPt8q1j0uMKOI1dI9VD8Zd4Q/nIw7QkPv33s6jb1f5
	yoCt6ux+PFvZ6oDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250819150105.DYeV89fa@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKNlshZmWsHVXBo0@slm.duckdns.org>

On 2025-08-18 07:41:06 [-1000], Tejun Heo wrote:
> Hello,
Hi Tejun,

> I see. Can I backtrack? If it doesn't require too invasive changes, let's
> just keep the two in sync. I'll get back to conversions so that we can
> actually achieve the goal eventually and it'll probably be more confusing if
> we revert that and try to redo it later.

Okay. Then let me repost the tasklet patch and make one for workqueue to
stay in sync.
I do hope that we end up with a requirement that any kind of teardown
does not happen from an atomic context ;)

> Thanks.
> 

Sebastian
