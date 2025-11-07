Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF5289374;
	Fri,  7 Nov 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548801; cv=none; b=Rgnln22aBQHsloDid9bAol3zw0Mju5CXz6tyW2pbcUMZP60i9BrA60GeAw3L1BJvmpYrw1ihe51xeIwLogJ3B9uCrIAFPeQZHdq1QH5LwD23cVMsChg2xYMtbqzWs+qZvKB8jrKvzGGgvxDUqiEgkFNP+pJPgK+QYHNXcemRMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548801; c=relaxed/simple;
	bh=DBmx+rm2lwQtKOPN9whXrQRvBhqEUJKcglae1D8o57Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE4zKeHTHrOHd7qMzo6C5Fy9dyqSl6rlkdmkcAcr9qcoqTgrZ8H6BqcZFEVDIpJjIDhDH7G1pYrFYROwYj/I771DAJ/tk8UBHIslJRRHw7x3bjvc9QOpstYU3vErt4qY8NQiFC4xjYdmHMdtGgzgVdYsJLgN+93lOj/4cE8FmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA43BC116C6;
	Fri,  7 Nov 2025 20:53:18 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	leitao@debian.org,
	mark.rutland@arm.com,
	rostedt@goodmis.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Fri,  7 Nov 2025 20:53:13 +0000
Message-ID: <176254876744.3846522.7990642471970534019.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105074259.209131-1-ryotkkr98@gmail.com>
References: <20251105074259.209131-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 16:42:59 +0900, Ryo Takakura wrote:
> For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
> their dedicated softirq stack when !PREEMPT_RT. This condition
> is ensured by SOFTIRQ_ON_OWN_STACK.
> 
> Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
> usage of the stack.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
      https://git.kernel.org/arm64/c/d3b570eba7bf

-- 
Catalin

