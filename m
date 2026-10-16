Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7C2E7366
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140446; cv=none; b=ZQtNrzvKCm+BnVmChKX1wOJ5YMRbKHM97jlcRluX8ZsTKz2RrI4hChhbMsKpFTTgMFlLrlMFscaSECElgSaOozzZ+MybaKFaoHwc4dRj+CIx3MtbVzqmvV7a3wVscdDSx6a2b8zlb0bCTdRbJpQ90X8SLGlaehVbYZVOmBS/dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140446; c=relaxed/simple;
	bh=lxJ9/R+nPocJAVyK7ncDpSazd9bCHXPMmaMpTjYhrIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PiDRRERN02n8iux8SJWorvrlkRC9hPy6wh9azd+OW2aBhzHZODcApP7kF6RGnenvrMDJBFHxjn9TQ34r3zjQCXSmubv8SDp6zaX6iH+J+8rGqfflxs5x05P49vKhnJr4feOMaBLru6aGQHR2CnYW+GtTuxgNiV2SVBclnNYcETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vCDtABU4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vCDtABU4"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917a04338c1so66630176d6.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792140444; x=1792745244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=vCDtABU43D7TAUJX6gUwELiJjVIEVw/RrWV/sIZwrNU+aXoo16ab68Tw1MW4XwK3z9
         zW4f5XM/X5FDEz+CHhYDr5tQJ4wL/WOtiChKR+z5ZDkAp6R389zaDWfTfaM5CbqjgQDy
         nJYRI0lXgW7QNjx2AY6SK0xuJ/eS5fIVd4i1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140444; x=1792745244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=f50+CCG1d8foKPa+3YzeANwxjE4BAbzK7NfzRzfj7PSPj4DH19iKpPXThPMWNrEYGM
         EyCp/dJTVhXyaLcfNsgGI54LSaRWl99WO7UosJ3xxqeCh/uI5ONT+XtoFouSDARwr2Zp
         inM0ld1M3qoQb2zloFGnHHX9ZvTMD+HF0+pwAl+htj46BAJJ4ncN0u9ib39hNinp4Ndf
         PLXczpbp6dasN/em+x2lp9Gd6vNAeACAn57kOUHwt5YfGiLprFF67PzGMZ2Ds+Zfjl/W
         c7lb16vZk4RY0N9ScPWl00VA5ZoVgJsFR87Mu/mNXtMuMb/y6hw3eHkM/1GjwNu5i2nz
         YwoA==
X-Forwarded-Encrypted: i=1; AKwUvBxrF/j+qJhL9CE3FFBpjybmWs8gd8QHmdH1wxZDXmtZcBRJCTZm5HNBua06myVYAvQzsDKXX5Eql8efSgVWkA==@lists.linux.dev
X-Gm-Message-State: AFq9FYL2e7QfNmB0Qeu4HCmt0/cHYhIOqgdrGSu1WWh+iFzErNc1MUZg
	lNknqnh7pG07/+CChsE5XgpBI/9DcLxxbzluyT+PV+L42LwO4UkdTPwGglAx/Hh7Pw==
X-Gm-Gg: AYBFou07icWSLj26L3pmC7GP0ac76R07jsTAtXU+Xx2c3DdxBULTgZpjx6zWM94GPgP
	IfddFEU6ZiqkCg7ahUX6FI5M4b9cyktDKA9u9+2BpkzLN/PO0DeWKLWGECwJiRKcHMKXAZ6VnBq
	668Ed5qjIDLmtpXYBWg2CvhWvNweSGOgN7x9wHkQsZ4/HslKhWj0q8in7LkofSjNEM3Wtjy/PTP
	zTTikF3bIGs6hsRtg0aPyZSxKdgY1IY8fhz8NHEpvoa0EfaR+pLogVTO+SYeEQ9l/jxrqTxAyrh
	TryqPuWZApB+WKAM0NY+8XUEpr3xUMpaanfV1Xmg0LLHgcr3GqtZzZToh8pwrmgJHS26dMaO4wT
	h5iq9s+tFSxkvtKEJ5Mcp7YimHbOiniphjEaNWSxrEUmSmcD6vTY2Pr3yrX4zTqXjrZGMRw3BTW
	0n8MyBbIWPJQH+470DW5tv/IMm8AwujfpIUR+BGdio8LAnoZUnMEhDZR/5yLxBlpZHE1qCH77Z/
	8ElXbSBSpgi7GQvf7qZ9ZIopfr8wOuvxcRIIwMxU9j4
X-Received: by 2002:a05:6214:240d:b0:91b:9136:d303 with SMTP id 6a1803df08f44-91b9136d5c9mr213297676d6.10.1792140444130;
        Fri, 16 Oct 2026 01:47:24 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm17863946d6.1.2026.10.16.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:47:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Patrick McHardy <kaber@trash.net>,
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Fri, 16 Oct 2026 04:47:17 -0400
Message-Id: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 49 +++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

-- 
2.43.0
