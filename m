Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504845;
	b=SsAGFs8sTAWyC2S6c71Y9AVs0M6UXcHcERbUefAG5BvPU4hvk+/a8Ape5lQSx6YpaIoc
	 Hxur0Zk4FJpSHMged7mE2aAvImmXjPUOK+BtdKB+UyyeRsOxd2UI/f1GkvP6y6Pae4oW/
	 Su4Q+ukAtt6WdzsI7fJh77GYp6IX/XV9MxWNSZy68abc9mg7K7GJHhmum+8U1mQCF5Ziu
	 zzLsk5p6QhRBDzrADxxDoQVuapzS+JnboH3crz1FTNA0f7/4HdxCYCyDa2XQIYfWQp60/
	 xfumR4JQQT33k14LKWefFEVhMapxFr9TwguEPx4BH9J84yFauc9vmkth1fzovjlpK4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504845;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+EaSSdk0bGKa5Hs2krGTl9pB9GbzsEWorWUGyfUVJkw=;
	b=Q5HvG626zwl4iN5H5bPhuG43oFRX//BeMi3Xgq0CpICIICQ5POIvGN7ZiQ2i51+rPVTQ
	 CXR3CRtVLZBUQ2KmKxJ36/wZvjSd+cIl0CiZasGRmaV54uPWMqrWfrTQgL6EBdWtdqjqv
	 rmLJ0hWnuOw+VZ1htVKnGj/HudWH9Gi0EHl/tFHPwJW/rHNRsRr3h4YU45Q8R/4dVc3M1
	 W0yLxOCc5eUzLdxvVyJaRbHXaGLsjP/DiK36jU7nlt27i11USNnvkFX2/PVUPWObZX3Ys
	 WSoWNJ668gqf95Skx8BF6mrBjCpq4Q/hkjvfmkoDLZLyrqZlOJvGt5B3BB1tAJlT5pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnpBvjBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF8606A889;
	Thu, 12 Nov 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnpBvjBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12711F000C4;
	Thu, 12 Nov 2026 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504845;
	bh=+EaSSdk0bGKa5Hs2krGTl9pB9GbzsEWorWUGyfUVJkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fnpBvjBm2TEDCsZOBWOXfQLw4GZWjh4srWsyeXI8IkmPhNtVjdZvLsiJ3tpajytL6
	 siIK5s+yV2RNPPqAcwlRq6ST6mK5Bu2DiuTUVxxO7lR0WfrY2uNeHLBFTgk2g0stt8
	 IlIRZk3sIVKugmA1XvEJl2zX8bKFImAA5GyicxUjfLwJC9L55gmFo2cu6HJYNp3MHE
	 /PNM91mH5nDtY0ByceI+ViFKaG5J30Tq5RiDANw+FWhPpPrCSl2fy8R1RQjIU3Y0pE
	 RME9PuZyUNG8pmPMbx23lamup/fgtPgaY59zhlhGSx0U6nycmSpEsUeyEkxnh3gQiE
	 cMhUPZTLJCzqA==
Date: Thu, 12 Nov 2026 09:34:04 -0800
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
Subject: Re: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies
 at retirement
Message-ID: <20261112093404.40b823e3@kernel.org>
In-Reply-To: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
References: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
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

On Tue, 10 Nov 2026 07:22:21 +0000 Jingxuan Xie wrote:
> Subject: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies at retirement

This patch does not seem to apply any more?
Could you rebase on latest net/main and repost?
-- 
pw-bot: cr
