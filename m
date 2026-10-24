Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852460;
	b=KAAw9xgb+1pIgsYwWnJfiWCIpDeF8+G+6T+yeNWHlJla6wy/90XFKs9RlwwA0oh7jaoX
	 nH8EOuqp6Jr6QA9eSk9H7Xl31QSjnJKAulYkXHkOh6X7VNEiRwfY3rBQTwtEyVQQjSK3B
	 rWJCN1nPT9uJMVyS0QUWc1uam0Bgq7g9EctcsajoTZMUIq5hkTi7J80D2WHaLAHVcAeJq
	 FnPsfho95qe7na/AWaRCYtEseAmqqnC2VVAV5r9y84558dKP9snYgIblMmM1OuLUQLyu8
	 Kt5RzEBzPOkdkp0G9XZpOXUxk+9WFllBA/Rya2PcKrhYy5jZkHPe3w+UiPSPwBw0Jqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
	b=3tDdRTFGXvYtNzqAESbCKomQkPrTGHNXt3JsG5pt0DZl5o3/D52pJ8CUS+q6e5UxVNZt
	 qSteKgLxN9J/e5uywCuIwizhNz5b4u2W7WRxVqk3r3naweToIfKZDJPN3czqLAgMgsJv9
	 n97zz6H313zfYX3LY9gP+oVNljgRdZWMF49IJ7p4G3RW+pya35J5qZrq6qCGXHWKGUcFx
	 RbXOKfC8nH7XwbL7PY7oTK/bg6rE0yE4CbKxYn6aup2PuXKUGT7huHnTS6jJhVr8FE9em
	 Z10cBTJ28bt1KTIuuWQoCTETPiBPQjwalGLHpz9qS0g/YhhKlx+e5y7qrShnplsInhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t1Q5teoP;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51022606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 14:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51022606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t1Q5teoP
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91bb5795792so20346026d6.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852459; x=1793457259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=t1Q5teoPDDkoAM58ifQTNJDlCLuHAz/xsUiD/MUrpjVSgAHCdqZcmIHGPS7jchnbba
         PGwbLVXa8WHxh7BgIhHcijvIIzHEBHMZBMmKViT0dqF4U24cWf3LOTWDrOLNPtaWciJb
         GOlNW3uZE2U8o7lJFgbeZr6WlXBWMP3t9tyQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852459; x=1793457259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQA+OynjfjY036ybXbiOfQTgbOLnKOtIL4CZzoyqqmo=;
        b=HwsSLE9TuFPdnJ9LkWyUmGZaciXDboezNbHc/ArXMUEX/+0ZNlSG82Q0fYN92Ci4FD
         iRxX1QNpMnTeG83+EeocNUpUj7arSGPQXOZlGneB8k5SXdEyyDVUQj6F2oi92GZwJxQg
         sV2fr3XGHBPAOvBchICgHLfxXAdsgGLZPnrwqcUBcSvpBofYihkJmsRNT4HDC6I8Rbam
         xkQ+PfSHuqg9GVPw41/PedeOqso9uCYHd/f4trbdh2jgSri+ozd8TEpw+ta3o3C8GGqg
         1XvVPCVOdiOvattRXtbQrw0LI67xycpKTNPl1texAKqTRpYr8RMOenFIzbEMiq3OOe4h
         VXpw==
X-Forwarded-Encrypted: i=1; AKwUvBzeoddsqaMORjwe9EMwy9WIQXYpQUEFGsTxw4rRHJ2xaUbCK1sBSNz/6VU7pk23HKtZwzUsSvPMYjnqCVezAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJDla/E4WA0Lm6VmtNe5+JWhoSJbIgAtpVUUKW2IUq3K0irekHS
	xQxggUVteChZs7jdfcWlcf3U2DshMOJljjIBG0kjR39RsRXixlFrlOomlS5wrVLz9Q==
X-Gm-Gg: AYBFou1NLdJIq6GcJvL9adUzH5Ds0sMk0Z+9frCFfGOCm5SQDatehu2ZcjuLz3UiDcl
	xhQFp1N6vOaM8JAk+skaCllJcfNYPnLPXhNG91qwRFslIpanS9SHh877GHjRl2SEw7s96KqPO8E
	BBp0tRgl/26OPZPFxnfhx1oTovTfKNVLnXsZevmQiVeqAUsZ00WGHF7GBNWCObsV6/gbSXCnTRm
	Hr1rMblDDQ82ebfYnlOuGwr563jQ/kccdfgwTUO2TCY9zPwR8iZPbaa7tYGkSdVBwcj9FHSP4km
	F19DLxgBw5xtHybqHM1HpmwzPit1OTmFTRvtd2O8eVVp5Tkto+VU7/qnVRFoBq2ZDlkPmVRkVsg
	u7oVWO9xs9ZgpRqP48IsNVx0UVN/tcdmKeaENGSQLILEtNTpPizbSrnYWpfcrRwIBphfzLIRIrD
	YVZbHfv07S2WrqJwrh9pm/NfLG3IEC24pd4ZdmrVAAxd7tnbPP1e1havKQB6NmbDqfxjW4VoJ4G
	cKt96wtJGL+0GJBauuQBTbH4agyh5CR2e5d5HTzgZo4UFlEw3qqQweuj07mckotSA0Jp6SWPXp0
	hi24MoQr0Nj6tD19dC9E21C0sEvfwakaOuFnZFd0+o0=
X-Received: by 2002:a05:6214:da4:b0:91c:15a6:ead5 with SMTP id 6a1803df08f44-91c48e56e21mr32544566d6.36.1792852459348;
        Sat, 24 Oct 2026 07:34:19 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:18 -0700 (PDT)
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
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Sat, 24 Oct 2026 10:34:13 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

v2: resend of the two-patch series.

- Patch 1/2 is unchanged

- Patch 2/2 now fixes the drop accounting raised by the Sashiko
  review of v1 (both providers): only NETDEV_TX_OK and NET_XMIT_CN
  count as accepted transmits (CN can accompany acceptance of the
  current packet); any other consumed result, e.g. NET_XMIT_DROP,
  is charged to tx_dropped instead of being counted as a good
  transmit.  The skb-ownership fix is unchanged (Sashiko-gemini).

The v2 revision follows the review of patch 2/2
(https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/)
and Simon Horman's request for a response
(https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/).

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK, and stops counting
those consumed drops as good transmits.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 60 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0
