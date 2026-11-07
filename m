Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012586;
	b=Irrk6BY9rI/B+p7V6gT2D9qTxQJ6ko8dFN5wAi+jtmOGASun6ynZGGIR5SkJaqTz86hk
	 lXunBAwNwi5asgrnetPMfppyDaCFSkfrRRx2EmCF0cgtyT27q1+5Px/x9SycwE7tlkM89
	 I15cbWs5b0XzU12K1PSGKq1lEne6rE9NqeUhcD5OiRHoBG1om0ZPuB9OYDwGsV4UBdgg/
	 9txTFua9VArBkeG0CdCE8vLEzKS8zhETBdZAUQtWSETWVd6bWnXN3DQIYmCmRKBjREAO5
	 1dV+h0oV4kIioh+W28FncIOMG7fv5ZioruegQvAc8JxaZbCq++TZKayPflOvIyG0/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
	b=M+ehyZM3pDIvF3BWPQ5ATIpVGxxeKBzKXun3gGGm1JzxLb9vu/dbgu1uaR9CRSbs7ek1
	 X7lrRqm6WSuehBtjiN+DPIIC8Da89lKOCiQni/qqMXlryPchhJp6K433qCwcYCTgFAtpi
	 Xk6hUuC+r/DVkPKzelW1nU5B7wbgNfmKp2Vhpkor4VD7x9JEdNlLmNWhF0zEHsRnVmLRA
	 ddZgX7S7q71XceSs7eVWu9MPWpRZAjgHpPwV74ERkO0+qPBGpOQCupSE1I/G1jFw8EbmU
	 SzsL4s4ZbB/akmlA8YWwAGCe7IQdCxk71i6M9q8fAzI/K1SatAhhmHwJpd+N9iZBeUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=SuBnmHY4;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F726070BA5
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F726070BA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=SuBnmHY4
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36ff9c9da34so1573853eec.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012585; x=1794617385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
        b=SuBnmHY4MsAa/RWrolx0lUe1r8ZLAEM4QBHdS1GyWl/hszF5UcQaOVAUonsb84L5Ad
         LqORi+GZmbD7kB/URkQK8n0s1s7hAE22RVw1h3bUhwnFBB+kJqmDwb5WgleBRsfys+8d
         FDb1/bpMRWn5LpSxkjIyR4qH6SWsGZC3pcn3mps2F6a5plWZK1ymv260QZ/TP1sFLrVv
         Bpd7Y7o8jQ2Wqz6OmIAy9LjXksA6cvBo5S3+82SEkRjUnrOcsxLW9hdTLjjuLP3aAQJs
         HJyYy4XsqPHx1kJdGvTIRJdz/QRHsHPdsggTECMLD+AXeZswQGqJoliVniuOXDKmPMPt
         f73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012585; x=1794617385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AU8Sh3UWwtf5Levg8kTCXNKh0yXFjsBlmyC03UOP2A0=;
        b=zLwhgUqSwDq/BkvmIM+LQJqSAaK46K+ZJT/uUQNYareCICc7aYgLcljz20Wf7jszGZ
         Kxf95ZkQnQUFFGDfjvmvqtqm3f0Y/oDCK5/bIW5w59rUZHyiaqyoUB/9DDmK0N1CjrPV
         t5+TkG4loagLotxQdxtLLjUrXqU5qQcB1gF1qbT1/guE62dQK58oKGcw028o4ritLvI7
         c/E9JPOGZb4nqx2HhnnnitSfwS00aZqcVt549uNBFjJ3XqIHYkz4tB59JwiZGg7pjPzM
         nXXd9uWCnn1HC/mGiEOgZ5+0cZLYI7iVk7Os0XwtORTY6HuLQ9jYRv9Om7ffyrbH1lLI
         H1Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzitZ7L8uzUrBeMfjGxc9wY2C2tB5cejaElCHysmdwtrtDiDtQkAihXLYE4kcUlnITDjm/aU5DFxWEWFbFFmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+EbQQVACVC13FkSYx0yS3DuFyxe5/uvxa2WjECyJP6bW0A/i7f
	p27ama/Coax1pDNwPnmgREatwePFj42Yxl60jgVleGv35xjdO0TXh77f3uW+15XWOkY=
X-Gm-Gg: AYBFou1FfyR1Ihq/uChNNq2z4xtMrhSwpx6UxGYMM0KMlK3CQJSfdIXTmapT4grcSO4
	C5CimDbe4HQhLHP1EJqQ5YX9heRy9EeTpoy1ziAYt0UnG9sAT2lWuVgBwYfPQ45R5DjkuDyDjM8
	S3m3MEgYUOxrUanIZEY8Xh9f619YnwFFnafOAYBYuazs6RapMKaksGNMc/oTl2PGq9YLJWjv4P8
	Eaknn/rVZ7QSLCL9jS+KE1nWS8+5udt3Y+e6AmXxkSSxHE7ncaYqcsInjL7FuApbgwDDlHqKlg2
	ztj1ZsmMB01fqmliUzTcitihbV5n9YqF0KH7dSH2JJaPvsh6SEKdHYXcZaAA9LM8UHrYQC2Weyi
	/DKdbAalKrtRAbYnhAnnyRC+ePeIlgU7ytkMWQUbw2ZZVSKA0FiiULd58Ju/WDB9d/l1dVfopvE
	52MdNKcOtKk5RgPBTBo9p39MDuwB6hv+WGPDwPUXhE6muwkKFzE8KPFgPaTU6PYW6iDf9hhH8eG
	g2ZCoUOI60Wa+HUW8mR+JueVpNBO4mLYh7Vn0YM4GDzpWjciaQZuJVxovd4b1USHJhie9VVsJci
	pEUpWp3USrE/MwNMO0NJNi+qCc9A78fJ7e+ZjOuEiP9tnfxr8EFsl1JhmONTTIxRidRyCQw=
X-Received: by 2002:a05:7300:50d9:b0:36f:350b:3838 with SMTP id 5a478bee46e88-36f76814c19mr5876815eec.31.1794012584361;
        Fri, 06 Nov 2026 16:49:44 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:43 -0800 (PST)
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
Subject: [PATCH net v6 3/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Sat,  7 Nov 2026 00:49:32 +0000
Message-ID: <20261107004935.2627329-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
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
IPv4 input accepts a 0.0.0.0 source only on a limited broadcast, so the
sender has to be on the gateway's link.

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
index e4b8c02a0..c714994ef 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2499,6 +2499,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -2977,7 +2981,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2988,7 +2992,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
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

