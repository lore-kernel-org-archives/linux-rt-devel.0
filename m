Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966487;
	b=XmzXeYidjkGdZpEZoCBKo2RS1LTcI/RIpgVgNQNxXy7ROVQ+aCM3dknG8oWGNOdv0yDv
	 yoW+mCMiyErkOJ6rS2JKWzNtvMpfOPQPbYm/EQ8cSqbMRfF8KKej0UJ8Mg6ZHwg7VPheu
	 jO+WAMSOEgnTk5QjRogsbxtNSZU9cqmu+08xMKn0+WzcjKgiMellwrJe/xW//NQ37icrV
	 29D+Uoylv5ZVfA6LzMgIz93EZAf8Wu7/vluXC8kmA4ZvVmFq9CH3N7rED/xLioxiKdbWP
	 Dz7vohyj7uPa9wToTI54eB3a7rs1C9+ucgyHzuhhxyRjJulxKYYljJifNnRtMjAHAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CZRMZMPzip6j1jlkCZw1OInn7jDQX9hu2P37kJnL3Sc=;
	b=U8sOr+8mR1Tg/T0fiakfYVSOc8bdFOcvd/txKGe9KHm5qqDjfgnGvRmzsN2hRcaJ2JGE
	 oz593b5qTcRZNKs8+8lPeohSOsU/ERaJo0OLeyGIqIi63IhSYa/KiIFxmmyYNUZAA3QIO
	 1CX/hrqK+VJEF0HPla/NdkNs3M1je62Y/DkCkhHNUDIfb1caFjGJ9B6VDTvIDjyM70kNf
	 DEm/pymy9ynSgHy+JQCTZzUFJYY2iTz6c1SaV/zmZMaC/3rb/0lajKTM9d0EwbyjJaYx7
	 Cp5uswrCYAZfa7k+jmZ/Adp9kmrZY9p8SsUXgFkrGJXVdDowqIFvOxB/qM/zKQfv30w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ggh/wjU3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019E606A31C;
	Wed, 18 Nov 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ggh/wjU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7100B1F000C4;
	Wed, 18 Nov 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966486;
	bh=CZRMZMPzip6j1jlkCZw1OInn7jDQX9hu2P37kJnL3Sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ggh/wjU3ebb2PAKVohtI/TJX/25xuKl3Pvvc+jlWHWC1YS0V8qUdlmGYGhMZP4jTm
	 EZlmd/jpettYttvlEJD3w9uendrIto23r94I9r+YuZ41d2G7Lp0XrnIj1DoSs0qFrl
	 +scIW4JooKd3VB7dLJ7GeDh9d0v3HHzLS1mrnxAbvOc9dxFUKXH1f549yQ7EiOs4RQ
	 PmWEB5efOY1VVUXB85c1Q6UyeoZVG3ETMYvFG65THeIjK79bT7GKFP/hN/O2d7ZDwm
	 OZLG5EO0TLRl5DqZmEp/kjm7N6hh7HoEZ3PZGxPGxunlXCReyAbyQXoXtwSchAToM+
	 sEN3laiojCzNQ==
Date: Tue, 17 Nov 2026 17:48:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?6Z+p5bCR6Ziz?=
 <shaoyanghan@deeproute.ai>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies
 at retirement
Message-ID: <20261117174805.709ad32d@kernel.org>
In-Reply-To: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
References: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 02:38:09 +0000 Jingxuan Xie wrote:
> Subject: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies at retirement

Doesn't apply, again. Looks like you are sending these patches twice.
One submission looks normal but there's a submission with the same
Message-ID carrying a weird secrecy / confidentiality clause.

Lore shows both:
https://lore.kernel.org/all/20261113023809.24730-1-jingxuanxie@deeproute.ai/

I'm not touching these patches if they are "considered top-secret
documents". Please submit these without the "secret twin" posting.
-- 
pw-bot: cr
