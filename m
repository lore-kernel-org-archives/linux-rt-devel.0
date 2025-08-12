Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC382D0C9F;
	Tue, 12 Aug 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027532; cv=none; b=W8qPkLeik5/A4GJKVe23HTUFOn0h6vmyNtUF95mjusfxlWIQQsc9vuSs4A8a2Fzz0AIM0uijSWPgc4AVoiV8/0bK1JSCEl5kclJ8sZ2BEglj54l4dqoMzy0zOEm0kUcn/BGiSK6yevKr03x45WEKbV79Ume0uRRXSJQDCSpEKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027532; c=relaxed/simple;
	bh=+ujLnmmsJTu1U3npY6IaXdXsM5M08opeg5Lc3MecZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKMKIpEXWs4WNUQtdsFaBgjjz9qeo2kV7WiFCzpCFGiyvnId4fmnaNW42cvkvXcpT0GsHQQdcEaZ9H6AbULDBKJBAB/H4NC9omI2X7RQNWvT268zGFLuuLSxVpgdWEzf0mkPMSN2rWpvgAtTgDLUKZGxT1Pq7UmWffvyGZVz/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM3U0Nat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM3U0Nat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80895C4CEF0;
	Tue, 12 Aug 2025 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755027531;
	bh=+ujLnmmsJTu1U3npY6IaXdXsM5M08opeg5Lc3MecZT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM3U0NatKwVE+SJ74ACZpM8En/OIR8zpqB0P1r8sAGsuOWpd0KQ2VC0roM5sgcIMI
	 YLfSEiZtUaSM9+68UWWNT2sGIiFad0opgSZlpUy0p+a0u9Z81J8n4TFAOrpy7yoTS0
	 4zH67C9JfSB6SAm8Qs1+GOZoDjl6TYDBkmM450RXVZngkqCHz0LuvLm3bg7fN2hWd8
	 k9UKDkJaNo/jlc3Pr7Ym9IjrOii/QiB73mcpIJdTALGTxSvVjZuQ4VEydTeDniDngj
	 vNTeAYYv13AJJm/rfuYNLN5zuV6GwXpV9HMNjKch2XCx/n6iQWEJQNfSxS5LCkj4U6
	 SVv95rGHO67/A==
Date: Tue, 12 Aug 2025 09:38:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aJuYStGVBjyfVmZM@slm.duckdns.org>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812145359.QMcaYh9g@linutronix.de>

Hello,

On Tue, Aug 12, 2025 at 04:53:59PM +0200, Sebastian Andrzej Siewior wrote:
> Does the workqueue-BH code require the canceling from atomic context or
> was this just added because the API for BH and non-BH work items is the
> same and __cancel_work_sync() allows it?
> Could we avoid the busy-waiting for BH work items and rely on the
> wait_for_completion() below or do we need something similar to what I
> added here for the tasklet API?

The intention is to convert all BH users to workqueue-BH and remove BH
(that's what Linus wants and why workqueue-BH came to be), so the APIs
should be able to match up, I'm afraid. There were some attempts at pushing
the conversion but we've only made minimal progress. If you're looking at BH
users anyway and feel like it, please feel free to convert them.

Thanks.

-- 
tejun
