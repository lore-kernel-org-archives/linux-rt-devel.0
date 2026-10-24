Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848660;
	b=3HvbBS2c54NpnzFrCKP9SAsGQ/dzP+YnhDGqyhJS4wugiHCRtevLjsoasOB/rxQumwg9
	 8q2+mKnUmfvwAjZv58o4CqHsFsKXJD4M/MyNhzOPAQBBjgpHKTtQ5ARbMCqXhR2FxMoZZ
	 ooxSh9K/qsoSmKofQgbFoMUnv5bHEtcOMfL1bhyjQyLi9JUcYexmY7U/hPRe/uVX6enj5
	 xf4uugv5+wu/tAb9Q3vDG2TtfsOqyqq9/WkeRPu0+PtIpPsBAEI2mpT5kYBBF8ApqCMl2
	 FaKRPlqCkfsekAduFNaBeMsrTBeOg/RbcsQoSzCmb7abqnw80aaejuaNHS4o8hCMyVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848660;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A1MY6H5B5YFmKLR6e6IGXuVoYXt232jFbf6/Clm0ZVE=;
	b=0eOqFgtzY6N+RLM8CegSeJogclcfF0ugLW73GJtR2t8Xj/CnW9b28zV3W/JcGEyE/djd
	 94plgC9WJ0kq6KiFZEyI99ncGg4HBGx18hmjXOQM20kCE8qkbWZaZ+0Y+Ps0fWIPhVkOc
	 n7nNyLMXwsPY9ez1m6tkTTafvrZp71QjUbnBT7/jPr3I87GeIG8KKz528AYharRaHeXdc
	 DK7ISQHzzJPVrXPpMqvaSAI+bbLhS7KZw6vY0nuSDd4Tli8IfBaOdt+7n0ci6O7pwQdXo
	 aobe9sVv1Y7pN4MFfK2aJrhYoRshUmxcyLAS3ROBIdFp/VXQXqg2KXIsbgUfVWOqO6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sKFKX80I;
	arc=none smtp.remote-ip=95.215.58.20
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C199606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C199606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sKFKX80I
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=UlY7QlMUrNEOh4hmb9le0VB8UsxmrmjM0k/WpNGXkOI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848656; v=1; x=1793453456;
 b=sKFKX80Ix84Fs350MK00f4edHKLj4RuZrmcwa99md6zqJCpzKHUFQlIICd9uuM9mYOm4M3QZ
 3urNDywXxldYI3t3LfSJMf0cad2aA3feMqg4sV0BxVHYFnIlF29TD6c/1SdiCiBSJAQ/LOY9QLz
 OyStvmomSFPOtmOMZ2HPnj7U=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 774620f7950678cc;
	Sat, 24 Oct 2026 13:30:56 +0000
X-Mizu-Trace-ID: 774620f7950678cc
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 02/15] net: avoid irqsave in skb_defer_free_flush
Date: Sat, 24 Oct 2026 21:30:26 +0800
Message-Id: <027595d505fb50c2bff406cec058d05c781994e8.1792847032.git.wen.yang@linux.dev>
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

From: Jesper Dangaard Brouer <brouer@redhat.com>

commit 3176eb82681ec9c8af31c6588ddedcc6cfb9e445 upstream.

The spin_lock irqsave/restore API variant in skb_defer_free_flush can
be replaced with the faster spin_lock irq variant, which doesn't need
to read and restore the CPU flags.

Using the unconditional irq "disable/enable" API variant is safe,
because the skb_defer_free_flush() function is only called during
NAPI-RX processing in net_rx_action(), where it is known the IRQs
are enabled.

Expected gain is 14 cycles from avoiding reading and restoring CPU
flags in a spin_lock_irqsave/restore operation, measured via a
microbencmark kernel module[1] on CPU E5-1650 v4 @ 3.60GHz.

Microbenchmark overhead of spin_lock+unlock:
 - spin_lock_unlock_irq     cost: 34 cycles(tsc)  9.486 ns
 - spin_lock_unlock_irqsave cost: 48 cycles(tsc) 13.567 ns

We don't expect to see a measurable packet performance gain, as
skb_defer_free_flush() is called infrequently once per NIC device NAPI
bulk cycle and conditionally only if SKBs have been deferred by other
CPUs via skb_attempt_defer_free().

[1] https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench_sample.c

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Link: https://lore.kernel.org/r/167421646327.1321776.7390743166998776914.stgit@firesoul
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f44ffac6cba6..efe483d7e03f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6762,17 +6762,16 @@ static int napi_threaded_poll(void *data)
 static void skb_defer_free_flush(struct softnet_data *sd)
 {
 	struct sk_buff *skb, *next;
-	unsigned long flags;
 
 	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
 	if (!READ_ONCE(sd->defer_list))
 		return;
 
-	spin_lock_irqsave(&sd->defer_lock, flags);
+	spin_lock_irq(&sd->defer_lock);
 	skb = sd->defer_list;
 	sd->defer_list = NULL;
 	sd->defer_count = 0;
-	spin_unlock_irqrestore(&sd->defer_lock, flags);
+	spin_unlock_irq(&sd->defer_lock);
 
 	while (skb != NULL) {
 		next = skb->next;
-- 
2.25.1

