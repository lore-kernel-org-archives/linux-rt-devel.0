Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883017;
	b=utBZinz7/SGFUrS70YKWhjoAqPrurUe6dCBs4d09PoHfX8nVZf5L56LOG5uWnDcZhE8s
	 tXTosJ7EqhwwkAvm4XiH3k2H6iFz8h6LKBL4z4Hek6isv5tRK0Q9xo1loOBiSuT8u3iaa
	 2nqxSY8KBSdCCJquePOtDXOccLT2xV8mUnZ07gEwRNLfy43Pk3YJmczsi7U1Yg+RWDGHz
	 oXVeRsZyxT02XE2l+z2i07mMQYyvRoegBlgDlV2WMVNlpiwuZqPMXHBki+AXS80T4qtfE
	 nQBa0RfhvyCUfbEGo/cHtT1RxlPGfpyx6YicQ806FPWv/PCQnjsPFoumP6/8vz/6rjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
	b=iyUnTuI7KwUaz4ql/2LVqfTTwfFZKgy/r7xGkRjp0TNhLw9P5OeqrIFzN9M5ePQGRW+H
	 ffUxdDB5qMxElsUdh9G+R/w+4iwrtGMeuhzQ6t5JYzSrF1tJb6F/n3cdmcSKO/CahhtsG
	 BOorsLP/8E190nJA7sq7pTrmxtSGKzFHt//qDPPeU9MHYZK+TbrhHsCCSh4ianySkZ3iO
	 wpg4sBWVy96lMUKSiAZnr99fvu52sUrpt5xgvPvMAcN//zq9UdZv6Bs3PVCFcnftILSuZ
	 mw2AK7lgDPyHTmtFfFNATAkTPfsIDc/lDxf7a227tkP2j8UYrj386QTkhE/6CfOaUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mauP3X5R;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C8606D813
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 12:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 500C8606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mauP3X5R
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2673187eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883016; x=1794487816; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
        b=mauP3X5RSYjQG9G1R0IGGkRFdUJPZpxWoR4ouK02rTPLdTliTVaayXv7I7C9cXjFJR
         6edNJhp+eGnzeL2II/TMG8PDxkIwujtox1J14tMLuuBtTeN62bBrPmg/IGqCN8jLKuPL
         wLJxlQ1D5CGNYR98BGTea/AM4U/0zF3XiMH9/FweGbaoQsADvcB+Azi6rtodRo3RIY0D
         lnwm3Fn5h5mpbqEQa1U1lG43mvH2XJtV48k9W11/dRK1tpM2oMxcaXFtk878x1CO4caK
         FBVgkc/0ZbbQrqsgUioF/VQ1L5wqyhEaydvu3PG2WHQhHasF28UOPrdlE7pGnAFD6wcF
         miTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883016; x=1794487816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
        b=FBjtX1+h0/RhrDYJfGZQ8J+6Qb692BNqxO2LFOuAss2XqISZlltFZFKpHsob5F2+KA
         N5k9FncEno1UQIkoGXnkiCHyrSLaWGBg9pGZJ3yxI/0IS+wDqeWVmFccqfCdvIEF1dzC
         nGok4ObsZq51sc9fhNgdKjT7P27KIZHEdI0acKDg1d/Jr9wWvFh8ryIRj1cR43I53tGR
         0iSVc/r6FBrJvJTiKc/vFzprOg4hra76dEr4doAxuHp6geDakUfyX6UoyPA8QYXLquiK
         ePdT5nv+MOSvST08xx27226Hvp+xuymbKs7TE+jqRDhvD2C/9uuAxMu3PkI/jVSGj91y
         Y4IQ==
X-Forwarded-Encrypted: i=1; AKwUvBydtD9EeffPfzqE3ZSTMPDVJ2eddZA1Ou8JnQfPLxzrh7y6M7IlK8jZqTOadmqwy/ocpZzWwBrw5xJALH6mlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+L4qxXjtaBOF/kTwK3hYNvUVTTywle7m1946aekh/d5bTGznVr
	n4NgLyiOtn5woUQpE8/8MuwUrc4SJlPJuDQr8c/iivtyb4iyyBVG7gK76D6QBx6eCBs=
X-Gm-Gg: AYBFou0l/WwEdNOXWl0fEUA3iltFFquKV5SHlq9qJXWC+IvRUcGIUzY/CROi7EpniFv
	yTvGimNEFZfoh5oDkMguuRkUdpPLHQpIBeHhCayITibzoO7bmjGlRE/fa7Jc5DA+VNOIm2ggjuu
	WJkE4+w7zhdB5F+HhthzZ+AzTYXPvuLQ1bXsGLfcj+m/8rL5adif/HelZ+hIhdDbeKoTIGmJQiz
	W5CCVBP0adRSnGUGksx0zgtlsq1G2TkVnxDfO6CkSmzeMdNDuiH1jUhwqc8YsM/+Ievx/GGTpnm
	E8JbuwNMKkwA2xgw8Fk1+rkVTo4Am5ciQ95iv/jZThX+D0Vs92iVVvehBf4N4rt7FI1H00o4Jq0
	XTZSdm3VsHRfwkxbyXCoXoPMCKcxfORGBYoQKQwSTx504nFcgSnc3a6qG5aBjJ9y+hPja7z/6i4
	qHx42OXTb9ML/nNSTOJtxbBjciewQog2ZQpAbePPJ1O3qE+3eTJgjQOPhXi/BB/FrMUyjngU7Mw
	jWbA9VBSV5uHUIEL044bq9mrwUmKVzpywK18qJM8QY69snWon3pDgMOMqrtIxfTGlx+KXAwCZEf
	OkiiG2o3Avsir1y2mZTqEQszivgZGnYFohIGQudPrP2cKlPqIm3J0EIcDY/FAOr3Uaf4gKg=
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr39609834eec.37.1793883016164;
        Thu, 05 Nov 2026 04:50:16 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:15 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 2/5] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Thu,  5 Nov 2026 12:50:07 +0000
Message-ID: <20261105125010.1107546-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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

A gateway's amt_rcv() admits a Membership Query or Multicast Data message
when "saddr != remote_ip" is false. remote_ip is 0 before discovery has
learned a relay (and is reset to 0 by amt_dev_open() and when discovery
gives up), so a packet whose source is 0.0.0.0 would otherwise pass the
equality check and could spoof a Query or inject multicast data.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Found by code inspection while writing the IPv6 receive path for the
AMT IPv6 outer transport; not triggered at runtime.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index d8914d811..dacfd5524 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2482,6 +2482,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -2958,7 +2962,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2969,7 +2973,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.47.3

