Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848696;
	b=Df9Akvrsn7x3inB+GlXqh1YadRUYsZV8xh6nF497xa/Tg2mm1JaTnl7iLPX0kQLeMUo+
	 IsNz8K58aU5nn0Sq+X5GdBzb3ghL9BClwWz1y4XtiC7wOoUA12fZRj3wDJzG/gx9WO9o3
	 U4sV9b0rSwwVuM761uZcTrgoapfJ0wzhxstVexaQuq06I1HvNbCuj564cZdyuvutdChVc
	 mq6J+2/RmCkQnHeosdxtE9msPij8UpMD3V862mOsXeW77fLyu2t7boAbJmSXyBRdNmu2L
	 F1vAcBHAYnkV/cbuz6OEZ7YZP9bUvD3kWN1x9S8YkhaSVC3dJtQHhPmfLL8SR78dttA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848696;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BLVTSJpUGSzCIj0vrYrG6/9/cbbpDw4acarOlU/cDsI=;
	b=BLw1c/wfmsEJ9Gz6lfUu8GaFDnd8NgMZeqFl9Mx1AFXCNg/LaRJAt4cspQXfBSmBJR+t
	 6/CtVyw65mjRZQSndAzeP4PkrTZsDOh/4hEy/XSgYwbPTD/fJ9Gi9S6tYdHBZq9QtP5X8
	 cHvfmvus/CQ1T2NY0S39jwje1dt6r6u6YsC0Lw0G+HE63VJuFKspkjbAnnBCtwKoV8PQF
	 JTYgX65pSe75VpHrGk7WWAY6yXBCsMrLT4saCTRdypc4wyriWqWNjYtKQdGMYgynddPiz
	 XKJV6IX4PQFmtlFcVSDKBhFxTO6pv3SR438IJcjXJMWDSH2IffmCfUZybLjgnMgQ8wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dryrlHRy;
	arc=none smtp.remote-ip=95.215.58.50
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3C606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F3C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dryrlHRy
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ezuFFUi6PivDxuUOseqtDzW4aOjW+5v9YWvmNMVwCvw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848694; v=1; x=1793453494;
 b=dryrlHRyB5SIo5gf/a4z9o5irx7Io47J3K8pl7jPHTyNSjMPncUBDQztUzPIsvCxDCIsfkUW
 1JR2TS5g9BFFigLGGj6xFAO8TpmbPJCKo9mcbcR5xACWtPUv1hoNVrLrqFvO7jbBUaTH7sUnALg
 g8h/GrR4lyID+3Gjg8OJ7zj0=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id e410ec36f51c1404;
	Sat, 24 Oct 2026 13:31:34 +0000
X-Mizu-Trace-ID: e410ec36f51c1404
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 10/15] net: make napi_threaded_poll() aware of sd->defer_list
Date: Sat, 24 Oct 2026 21:30:34 +0800
Message-Id: <d993b852193bd5bf5dcc784992454f8c02801588.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
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

From: Eric Dumazet <edumazet@google.com>

commit a1aaee7f8f79d1b0595e24f8c3caed24630d6cb6 upstream.

If we call skb_defer_free_flush() from napi_threaded_poll(),
we can avoid to raise IPI from skb_attempt_defer_free()
when the list becomes too big.

This allows napi_threaded_poll() to rely less on softirqs,
and lowers latency caused by a too big list.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index df7df594e7f0..cac16e17ccf9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6766,6 +6766,7 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	struct softnet_data *sd;
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
@@ -6775,11 +6776,13 @@ static int napi_threaded_poll(void *data)
 			bool repoll = false;
 
 			local_bh_disable();
+			sd = this_cpu_ptr(&softnet_data);
 
 			have = netpoll_poll_lock(napi);
 			__napi_poll(napi, &repoll);
 			netpoll_poll_unlock(have);
 
+			skb_defer_free_flush(sd);
 			local_bh_enable();
 
 			if (!repoll)
-- 
2.25.1

