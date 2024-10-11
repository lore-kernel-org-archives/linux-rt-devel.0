Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741955381E;
	Fri, 11 Oct 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662435; cv=none; b=g5g0YfowwAWzkR7r7esNUGTQGv+1QeHcSUGJgLO0bnvAxChX00C0DHwOQ0EA0mxjL6CH9LM4oMuBN92vF45OlVpeG8VncD5Wh6PJBPQaSHbYoJqdDiGMykfScrxbXRqqQEZfZsadUP6JO+vK26M/tDqnobXapQE+MGQpqw2CM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662435; c=relaxed/simple;
	bh=RfiUuucZfFz6bVN/J399V3FUMktBgjKhhtlAEd2eHkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACYVuQE1Wh0wuxnrbUbEdXrc+mPsNgx/mitgKksQ7l0d71oZF+RldGAHe9Z1C5544vIDQrBvehlkBKi5LbLSB0Z1LkTxMwAmd858rZ2pn9YRAhsBv0u8WuowlDDjOwon6pLyjsCoWB4CN+69F9mVTrKnZtkdlgAumD/ttZzVsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnIcVQux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnIcVQux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E61C4CEC3;
	Fri, 11 Oct 2024 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662435;
	bh=RfiUuucZfFz6bVN/J399V3FUMktBgjKhhtlAEd2eHkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnIcVQuxUgsF+wxuN7reaQzBPDDmBvB8hzIxbQBfuUXAYjlIo80QTzaS8SLV/DZOc
	 zSAgLE91RRFZdwIDghOb0G2XrdHSlNmHLw2fAXPpwF2hXu9HruXpAORTFI4wDijord
	 i2esrE5cuOnWGzmeux1jPsIfNp5OLFE6+QbZLOeU0xhVgRA+IicWDdk6E27Y0obkXR
	 6qr+dgnR9H0aC4LgOtBE+dLM5iBLahcEKOawqys7BnxsdAQX523rdJ4piWJjWtHl5d
	 DeuEHNmJziVVc/bIHasbU2qhNY6/0AsqBEwScHzqA2669pbpjBcPkw9fyPuxAvjuua
	 vvW4BmXwcqzSA==
Date: Fri, 11 Oct 2024 11:00:33 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <ZwlLoWfeWyvE22Go@lysander>
References: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002154639.89wWS_OU@linutronix.de>

On Wed, Oct 02, 2024 at 05:46:39PM +0200, Sebastian Andrzej Siewior wrote:
> Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
> volunteered and asked for the list.
> There are no files associated with this entry since it is spread over
> the kernel. It serves as entry for people knowing what they look for.
> There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
> the entry will be picked up.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Please add me to the list.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
