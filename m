Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235761;
	b=aeVyGUD4MKyj9CLl4SiQXYSe2zRIMEk9hr7n2B6FsWtQUJ58T0AyETlHJbSUPrTs8TSG
	 yYlq6DaRCuIZvCwr2NiL8GtN6I1JQgx7lnBMJMvH76A4Aa+nsUl4gFZDg/v7XoaGmgePx
	 W0zgKpNVAlJhbcJxm4OdfqHbzWSWVSdWW/QMbob7vyhBt9U4LG2ShB50HdTr/uoZsaLl8
	 0L+p6NyJa1UPmlDIjSm3De6VcdMe8fOMTdmvaNp/rYy1EX8qgmTpx0CS2PSW2ewnRp2M5
	 rg4BPQG11fSmSQuiSg43181zKVurOruqBCpJmV2KHkx5tqkoHph6GTrXpXe8aTZ3rOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235761;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JCuBE9rYwaqc4RBfcgIVaBjWp20I290RtM10+0Z+wSc=;
	b=RjLhB9PnGGX8mM8lagotzvWIDA7/gmqKADhkpUfG5ewxTPV2eXqw9fmTvI5ck+yTPz9c
	 K+l9KBZDF4KscxyetANJcHFDeS7bumz9Tyqzz5nOTpipcDUC74//h6NDoffkti85Our5U
	 Sa1BveaqHjYxOX27iGdScoGGkuMAR8bXJNyMAW4VmFLgiPOTmiHEA1qVVu8NxWfPzEsJ0
	 shtab2PcY8uiuud1OtqDhaL3E6CiMmPwB4OOM4LtrAUtKCopdhEw57Xj2cQLNe4T15Cpi
	 oyLEG3KwzMq0Dpf07P90bqMFuOlNHGXczyZ+mhdYKI70pvQtfiljUshy+ck8iE0WmFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRwEMsyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC5606EE9D;
	Mon,  9 Nov 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRwEMsyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E99D1F008A2;
	Mon,  9 Nov 2026 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235761;
	bh=JCuBE9rYwaqc4RBfcgIVaBjWp20I290RtM10+0Z+wSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QRwEMsyRD08u9TEsDafDWMwx8IDLLypjHbFQ9CdXRWV7eSfRfmPhbDtOF41wZi96e
	 iUViSto727I3b9Ot3xjoHhZ0Lm67F9QQYzDrjuIclc1a4a4WmwOkAOffCE14CvIYKC
	 ziV+YJyQZtUbNe4D/WKN8j7ROeDgOYmOcCkuxEOo7HfZyj/cxAZDpCPKWEmF8lRlun
	 d7FbTNUa1mi779QnLRyBS4haB52i8TI9bgjttheUqiSQ7+qjo44V67trBsDKeopuNN
	 mSxez10Jf0pmzWbC112mYHwGDbakLjSw3GkzrF9eGsC0zKsS79YSP3BoBTwQDgwfb3
	 4liYhm4WsxZ5w==
Subject: Re: [PATCH net v5 4/5] amt: make pre-query report drops visible
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev
Date: Mon, 09 Nov 2026 14:49:19 +0000
Message-ID: <179423575970.994134.5432026388018419992@kernel.org>
In-Reply-To: <20261105125010.1107546-5-omar@blockcast.net>
References: <20261105125010.1107546-5-omar@blockcast.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says DEV_STATS_INC() is applied only to
  amt_dev_xmit()'s counters: "The device is LLTX, so amt_dev_xmit() can…

--

amt: make pre-query report drops visible

This patch adds a debug message when an amt gateway drops an IGMP or MLD
report because the relay's Membership Query has not arrived yet. It also
stops amt_dev_xmit() from counting reports it forwarded as tx_dropped.
Finally, it switches the device's tx_dropped and tx_errors updates to
DEV_STATS_INC().

> The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
> use DEV_STATS_INC() for its tx_dropped and tx_errors updates so
> concurrent increments are not lost.

[Severity: Low]
This isn't a bug, but does this paragraph cover the whole diff?

It describes the DEV_STATS_INC() change as limited to amt_dev_xmit().
Only two of the converted sites are in that function. The patch also
converts every other tx_errors and tx_dropped increment in
drivers/net/amt.c:

  amt_send_discovery()      (three tx_errors sites)
  amt_send_request()        (three tx_errors sites)
  amt_send_igmp_gq()        (tx_dropped)
  amt_build_mld_gq()        (tx_errors)
  amt_send_mld_gq()         (tx_dropped)
  amt_send_advertisement()  (three tx_errors sites)

These run from the gateway workqueue and the relay receive path, not
from ndo_start_xmit.

The extra conversions look correct and are needed. DEV_STATS_INC() does
atomic_long_inc() on the same storage as dev->stats.tx_errors and
dev->stats.tx_dropped. A plain ++ left on either field could overwrite
an atomic increment from amt_dev_xmit().

Could the commit message mention these conversions and give that reason?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105125010.1107546-1-omar%40blockcast.net
