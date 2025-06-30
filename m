Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF1283FCE;
	Mon, 30 Jun 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288858; cv=none; b=s4/lJckJm0DqxVqSIof8L/gXFdBmSz+gfkyCwECtoG1pAnxpk7QCeUNZSOmmykzC3OPOpbEyIjikSDmaXT3maU2lcC41yHmMw/HdZxi/C5jRGHUqqHuAofvzePc/2wly7tOyEugdmclNR+SzWYNYvQIbUMdoQHf2YLSot41PNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288858; c=relaxed/simple;
	bh=m8VBM58aGaU+6xvtNkMoQZt0IjZAuRYz5bs6w7J+ct4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHMq1ExCMGIKP3YXLgq8GzCoPcDEYS57b8HwKESdpQm3B82CV0XRRFkreH6d1lVul9vK3hSHMNXNVR6lY5rBiC1d9Gb9doAb54gIy5ueQvbvEu4xQCGUtENqIZ8U1SUUkOkYQLmhlmqvKvcQ+V6Ruw6H1GZgalJgkvAj/Eg5Tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iaDX5f4i; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iaDX5f4i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sEov6JC4NDe7+ZoMd7zO649rqboiBPEO080p+eAfOKE=; b=iaDX5f4iU1f+Jp4v5eQtNdEbnT
	DkDuvqOYchSii9OESk6khJ2SXw9i8/TPsEvZ0kOhf0hWA/AHFNq5a7EwXfJN8GGuw5uOdZNN/WRGY
	Vm7JJkKhR/8XwRO3AyOZW4U9gN7788qJyxZQ5zM8yxeSxxi5s92FZ/WSlJ8d38wyjjHtdF0nioO7B
	leM+/rvhBJlfeI1hnrstWwmvbmQMuG3Kom1fByfjbwt4BlVEkdJNbyEZhBAnGgqBIEQX/2pT4NbYc
	N2yvGOnRuqsc8UL9cZG/7FoMUK9rZf76PPSOKp27LHsPryWIcatYv7QfNunTlNsxFqTPn/1FPJygq
	UL03Ly6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEEQ-00000006mJ5-0PZ8;
	Mon, 30 Jun 2025 13:07:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2006300158; Mon, 30 Jun 2025 15:07:32 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:07:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 1/1] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
Message-ID: <20250630130732.GK1613376@noisy.programming.kicks-ass.net>
References: <20250630075138.3448715-1-bigeasy@linutronix.de>
 <20250630075138.3448715-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630075138.3448715-2-bigeasy@linutronix.de>

On Mon, Jun 30, 2025 at 09:51:38AM +0200, Sebastian Andrzej Siewior wrote:
> The local_lock.h is the main entry for the local_lock_t type and
> provides wrappers around internal functions prefixed with __ in
> local_lock_internal.h.
> 
> Move the this_cpu_ptr() dereference of the variable from the internal to
> the main header. Since it is all macro implemented, this_cpu_ptr() will
> still happen within the preempt/ IRQ disabled section.
> This will free the internal implementation (__) to be used on
> local_lock_t types which are local variables and must not be accessed
> via this_cpu_ptr().
> 
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
