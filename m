Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344748;
	b=QfXxktvPyYTjZYIW1FkLZVbEhXkc+t49o3jc93sBFq42ofdNPycp3ZB9HKS8vWQ7h2Kv
	 +jOAXQ5VAWSJYPN5XKmTdVhqCJVigycfLxIwDBjrtLJrGEvf2rySypeTMQpF+GC6rSq67
	 UXbzH3YGclyrrTjjpShG7eMUSID5NN3Kqrw5q0Z43kJ0wSijEp9s8gzD0fVnWq4/240Ko
	 SCJwElzP4Fyi2w+B+QccXSbSc4azccoYHUARYNkRNpYlcsz85a2Wj8rTLgOTaXlA1ragJ
	 snnL05od5RhfRhbt5uM5rQhJc97aMnNx9eeC6mjgB0zs1w5jC6iqbOD3hs8+3VE/SWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
	b=gcsXkjoevZUf9XWVkcfy8fMD93wzWSd+kvGypw+ymZvzkIn7/P0bKA5BTFwH4oz4C7qJ
	 L2mhBteEszKSbF/WEPr/51QAoBYbQWH6AMoqpncTXkrx92/Jx9WLxgq9Y8/GNwI4Fi8RV
	 loLjhvh34FbBRfZeWEsttR5vj4TtcGnBrsbikrmIBjTVQxXaSRnK9qo80xSiLCZdL5y/p
	 zV1CJkvjtbkLXSxCMV7eWFI/xvZqaNmJhaHgNDWtqJfwmevSz9o8wG5iGe+D6HC58BfIl
	 wFy7ZkNtC6lrUesULp1dXVnqeaOn3fsqNH+zxvSk5pvylmaQb/J8p0Bbuzey0LzcLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=iM5VflAe;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7960A262D
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB7960A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=iM5VflAe
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so1910232eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344747; x=1794949547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
        b=iM5VflAeRiJQZOiI2XWcqY2wg1h/NGY9u/HltR5O2u6afl3r1h/4MlH+g0KRhUrxpN
         hJq8lZ/tUDEZ8qC/g4s4e4X6k0kQmiMtvyWf6eng4vRfHjb37Edw3+Lt4eVzn/4PvwNW
         gzXz6FsgK+R/mvWw2x3CnAh94e7dMRCV48a8ykgwKtDhk3NRnWY3nycPMIisVQPP6lhM
         2fP05TVEGc65rF1dBxjNBpuU+DoB0BjLli/SsBYaaThrrDbs0rAqpAHR6L0MNuKdk5ZA
         WXEJ5jv7DqpmMQPWCpeemx7U3VHYgB2W6nPm6dPA6ZSM7nTOLqY39MiVMuLUolsbgdty
         hJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344747; x=1794949547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlTA7sqBysXN+F6fe4TMgN82A274aSjTjJDiigwKkzo=;
        b=eMO8QeE7c3nen1v0naz9N+rsastw9ohWEwsM+OgGf4Ys1d6nx/qlEWwODgyIRYCyq8
         PXNlSMbjzVnN7/f1HK92zWF4sU4RWgChfhR2AdjQHXfc296U3cAz7TIiLYwS3PWBLHqu
         9cNh6ZBIKVduhQC04LmO1gXl0O+gLGv2D+yZ/Jsd0yqfop9qhXkRCXXjVP80kxqEOX4g
         p9aNswNHSevEtPgH165i+QXJhzVSIMEo+2REOkJ0fvqBapUDX+zDw+744/Ly7Js4tKtN
         ZN7yRJpfa4ky5x/jlKasRpS4VEcbLVBWQChL21D26W939wsY1eM2VauItsoAbLeGP5CH
         6h9g==
X-Forwarded-Encrypted: i=1; AL+hErHqLjzn/yM78G3ljn8cF1a/93fWJZ8/MO8br6sCZhVVef9f+T+g4tHcIo2OoKW/KzLkHtKAt9JGaay3Nu69lw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4piupAK23+W1jNkkyeVIqIabdakNe3jFzmnfCAhfqA0oTwS+I
	UBJdKMoYHKvE+MS00vJ2BWda6/s1552tPp+k25VlVWdZ+4d4k6y3KVg7x4VTMjGFM4U=
X-Gm-Gg: AYBFou1LbS4HU5AVyFLJdU0JFfyOGg+IbVrQjOtfzLir0C0Ez42w2CSEcsiGkXvOpUu
	RFP0WGbSwUsWNb8I9IH1asZml8Ch0HKEiW0h7TI/7AN+Qg2cdvv6cfwIjkbp39XSkcwtz3O4ege
	pSR2uWLnaThsY033O0sb1eXMCPzLqCocI8qMWN0Mb0I/q+Z0cRdCJeSCk8Vlmwmo1s7BaVEHeyG
	wzQgracZJT5bjhN2c1gQxJ3bEeaZP0dot4SmxMyjwwK6ukBtc6DXMRkD/qmRM1mwKl0yoAEDXoS
	EYmwYmTDv3NY79jKyY090am5J7qy9qMaLZ0fdUiHUyLjxYxN30e8lfMVJOHsdpjIEsIkRawSn3m
	DI+dsAJYbo+cKVTyM/X77c6pqiMLI2lY7jfK7BzuZzNmq8cXyA+zvP1VJFtc4TfiidADExZFL7H
	1qOb18kNtToCMilFDSa7jGs1X8ujSj1VKEjtcBZoYjL2LNZHqVyJ6mr5UwxS5bijy6zwWrhIGAT
	wekpScvLr2FTcbFYQIpHFDBbLc0kZqlf9mDoVVlDETWgSvDSzvEk2CFwMoMv/zO+DXpx+E23WOG
	J2qtvp3aPpaSMJTThCO+7KH7tAgqhMk3396KgPoGgPIFOZGaFJYF9Mx0dy175VYc/OPaXRA=
X-Received: by 2002:a05:7300:d211:b0:372:eab:d700 with SMTP id 5a478bee46e88-376831886c3mr635514eec.1.1794344746875;
        Tue, 10 Nov 2026 13:05:46 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:45 -0800 (PST)
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
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 3/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Tue, 10 Nov 2026 21:05:34 +0000
Message-ID: <20261110210538.217936-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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

A gateway's amt_rcv() admits a Membership Query or Multicast Data
message when "saddr != remote_ip" is false. remote_ip is 0 before
discovery has learned a relay (and is reset to 0 by amt_dev_open(), by
amt_dev_stop(), and when the gateway gives up after its Requests go
unanswered), so a packet whose source is 0.0.0.0 would otherwise pass
the equality check and could spoof a Query or inject multicast data.
IPv4 input accepts a 0.0.0.0 source only on a limited broadcast or a
link-local (224.0.0.0/24) multicast destination, so the sender has to be
on the gateway's link.

A forged Query must also carry the gateway's nonce. That is 0 until the
next discovery tick re-randomizes it, because amt_dev_open() and the
give-up path in amt_event_send_request() zero amt->nonce along with
remote_ip. The Query handler then sets ready4 or ready6, mac and qi, and
moves the gateway to AMT_STATUS_RECEIVED_QUERY. From there
amt_event_send_discovery() returns early and amt_advertisement_handler()
rejects every Advertisement, so discovery stays blocked until the
Request retries run out and the device is back in AMT_STATUS_INIT with
nonce 0. The Data check is defense in depth: amt_multicast_data_handler()
already requires AMT_STATUS_SENT_UPDATE, which a gateway with no relay
reaches only after such a forged Query, or in the short window in which
the give-up path has cleared remote_ip but not yet reset the status.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Found by code inspection while writing the IPv6 receive path for the
AMT IPv6 outer transport; not triggered at runtime. The Sashiko AI
review of an earlier posting pointed out the nonce condition, the
blocked discovery and that the Data check is defense in depth.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: 30e22a6ebca0 ("amt: use workqueue for gateway side message handling")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index fc3900e25..9f59ec6c4 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2527,6 +2527,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -3005,7 +3009,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3016,7 +3020,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.43.0

