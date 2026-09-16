Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89F1448E0;
	Wed, 16 Sep 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518210; cv=none; b=AwjlMo9wByhttkSnzcSt/mLHSWmyU553eA9L2S2uGZPhkv6Oes01RLNLEP3w61TTSXOpt5UFg+AKGrGGKyKAB1YMYlj3sky2GexX5CzODI1Yp5GWzOEGWuVyGrNOu4R3SkkKYflrjPQiFC1vAV//fR2lrU3U3lDmQpokYTUo+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518210; c=relaxed/simple;
	bh=wuhhlH/7+jcf5MBPe0TwRpWPFpaAPTrsBV49oFRMqpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZL9M9Hr05uHnCUa52HUJHLLSRd55NdnorYoYz/rgyoAm5gSKcEXuwHNROzfC2n+KdEEiWqc56cgAq6Xjk0fsq8xFK8ofocdOvfNw4tAT5JSHA7Ol1YY5nbJKn4/vUgOqE6YL1sqPddXmdlJtqj/2x8zrVVMroYNs9bWw3ftwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mma+gYTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mma+gYTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD8B1F000FF;
	Wed, 16 Sep 2026 00:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518208;
	bh=SYS4/jXrEtXSvNBADZuOsax1XwEPG6mdqebHxu+RWyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mma+gYTBjeieo9W8jbYk7KdLlVhJZ0kSPcF9zz5jyJpvvPh2peZOX/IpGtHPGhvrF
	 bzdYRv0DptmaUsjlm7rtUyr05czJWd0NTzLeUj/lTgjCfJQejzPYTYIOuIhNjxJKSo
	 072v0vTnIP7bhu5HVSsxx6CJEPb3wOqQxzssYoxMG8gVBmGinv1rp8Y69N+OGLeF9N
	 g3erWhgzclUFWAXvM8meOX0CrmI+S7w5mEZ4pBn8eaYqqVaWn6sNnQtFESc9/txd27
	 9q4p6Cz2MxR/DcKQ4aSJiJJUWJQTU4IK7/l7u+/vBaz95NBWOlIlk3ZJ9sTK/BzYJ8
	 QrjiOKnbF7jgg==
Date: Tue, 15 Sep 2026 17:23:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>,
 <neelisrinivas18@gmail.com>, <git@amd.com>
Subject: Re: [PATCH net-next v2 3/8] net: xilinx: tsn: add endpoint MAC
 driver skeleton
Message-ID: <20260915172327.1691aece@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-3-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
	<20260909-patches_v2_external-v2-3-3a40babaff4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 00:49:51 +0530 Srinivas Neeli wrote:
> +	ndev = alloc_netdev(sizeof(*ep), "ep%d", NET_NAME_ENUM, ether_setup);

It's up to user space to name netdevs, this is just an ethernet device,
use the standard name.
