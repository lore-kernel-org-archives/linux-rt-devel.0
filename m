Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787335;
	b=kgbqnj5EACSQIiU5oS3evinAIC9lCI6D80dhKgOp9+B96L7LAZY3R2ZRp1cZniNSHDUG
	 ZwCKIQ8NMjMGyo8SXhQORBCfEhIChhDdX/EnSw/JeDjeJkLirFmGf7ICINx7uPgw5xbWH
	 SoKJA5uUjVboLf2tk904Ce//bSskwA4fv7dEonohyF5itOanlT0mD225DIH4YMMKZxxqf
	 84TyK8WG5F9GYPleCaxkhWBZeAoex52dLMqlbjhaTik88jzVI8hIJtrTwrFgj7sH9p4kr
	 VD56mLpjd90D8Lu+pT6YqQvuPcEiM3a88dAQSd4zsd2PFzuSnnDudgojsIDIL9k3y2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787335;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=idIVx01jKUiD25RXoBpiy0J1bgQNaE+a8NGRhE2zYK4=;
	b=sVtRJ4n5EG5QZLHMMHlR7p/t4guOj2qRjia4Ig6NedGg/lyB1lFmodXvVMbUSUjYIuzb
	 zgbuU5NQBidE67SZHNERodHHQ7RlXeDjxuRTj1mpDUrzikVQfFu3ZKZK1O/ZCF0tMDsuP
	 8YwHy39EmPhHS5xFyQd8bkUxs+s6hcfl6JtEm9TxskHddZ+1VNGYj+XznOhmETt1tFMnY
	 D2d5YGpME477WDcuXau1w8mTf+O3IFZUahojrKY3AJxlEc23nnXI12yAov+PRdcgFgs7s
	 8zoyYXNnzQ58CD3QjG9LFbZ0eowdKM/lEvvSlvsHtIquia7IFl37KEvJYif3kQUxcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Fym85tL3;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D9606A6A9;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27D9606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Fym85tL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=idIVx01jKUiD25RXoBpiy0J1bgQNaE+a8NGRhE2zYK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fym85tL3Lnb/Xgi//8sDjmDQXFCxLcpTVk0D80RwTqohE3IAKfsBdqjMj3lRCoKFK
	 FKCxaCRk5XB05HrrC+gFeS3POw93O9VAalffc62ewaPQ5+KSxgZq/sohILpqUX2dNZ
	 W5k5ySH/DurYq6KjL25OxutG3irNywWwbR3n5C0vfkvf5C9y5SvF8ARUrfyZr7cEd8
	 oyKbivLzuP0GG9h3lrik9gBIBIyZCHMRcxsnRl6xIdSV7c8jHYr0mVlagwXb00BqhZ
	 pBgA/d/p+ipszbnX5vIVi31+y3znZyQ1V9V3JcLlEIpegtK/nne5tW3Ru6KWCezcNZ
	 91AwkVzIUoubw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg5dn8zXPF;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 41/43] sched/deadline: Run a boost held at its first refill on a donor period
Date: Fri, 27 Nov 2026 08:48:42 -0500
Message-ID: <20261127134846.114774-14-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234600@kernel.org>
References: <a6b6005cb9ccdba38560bbc40d1a22649432b14d.1795646915.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234600@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can keeping the period placed by dl_note_donor_refill() here leave
> dl_se->runtime at 0 or resume a stale donor's deadline and runtime?

Both can happen:
1. A runtime of 0 costs at most one tick. The next update_curr_dl_se()
   refills the task from the donor, as after an overrun.
2. In v12, a resumed donor period will take its deadline from the
   current donor. Its runtime will be capped at the donor's runtime:
   see my reply on patch 38.

> When the donor leaves SCHED_DEADLINE and has its parameters cleared on
> another CPU before the rt_mutex chain walk deboosts the owner, can
> returning false here after setting dl_se->dl_boost_held = 1 corrupt the
> owner's period and saved boost state?

It can, in a race with the donor leaving the class. What is left is
one stale set of boost_* values, and at most one donor period resumed
from it, with no runtime. The next refill gives the task a new donor
period. Your second and third paths behave as on v7.4-rc2. v12 will
leave it as it is.

Thanks,

Mathieu
