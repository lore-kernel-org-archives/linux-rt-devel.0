Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012581;
	b=wU0ATHagPn9bdPo2NwW6sRkU+lYO0XgvvSrWmtjBNwnS8bEHC5bI8g2yQi05iDQVjJ4h
	 d0pDgxbfcRRlFIFaZ+bqHOUxX5YYPc15txPF4+KMWch2lrFYaz+Mgh3ocvsRemxeMuBzB
	 H/ggr2TeLLsjFPLu2r6uzUvYOQuUmb3tHGN9RcL1yD7u1rk0lc2IPwImgRcXd83d8aAEJ
	 sXWW5+J8YR5YXCO9/wlZB6vodIaGfx9TJvpbS1GwAHzQ3Ib5RjaE1nVKMFKvlH/Oy/e7Q
	 IWqAbsx+8rQg07p1lUwjweuAkQWKyLiyl4ZX7KQ6pZLEUkLf0K7owS92a8a23Ne0mCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
	b=jCSabt6W0mFFm/x6hqugkD6GHRpcCcw3t4o+ROVwpo2ITxiJcEMHVcdFnG7y7Czv1Nnl
	 wBaYFXdRNfBctD4jYX5nozJ8OikzkZ9ILtQp0/oi1AhZsf9GRDYClhxAqErgzdYYu936H
	 Rossv4DWgqw8deefltJBNLOLd9JiC/qPxctrBSgWGDAiWBeVG+NQxS2y6CRcAOnt/oDf1
	 NPgFFAqM/SjG/yEicMOouynaQhKsEkUZbnFwWQoRYUCFiDXuH3CIgu0W3IU/CvNnsPFG2
	 S8xKMpvufsLpdPhnBGa4NpbCThEMJZ35ksXe/AHXw2AdGIeP7igoAVwMyn7VEQjP9qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mj4sWu8E;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB05606F9D9
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB05606F9D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=mj4sWu8E
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso1820054eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012580; x=1794617380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
        b=mj4sWu8EZ/f9ZsDmsazL8ryl2tFXuiVOKYfpOl24yv7UnmxJh5unubijXj2PwG7QAD
         cjJsvk5+qIuPz2MU50ZfOfGhOaDhSJo9MSHzNZUrLQDVsWSmkd+KDo1qc3ZkrpskaRhX
         TgUk0furxZuPUAYaIcDdTsyMv1wjOXSaadi5yvBGfxsJNIqbuSJxuJc3Waz9B5EXMWau
         pEa/8ajFOPPlwUT0DjA1mU5W5sZ1I9MZle4ISA01VdXkBkI4MVeGLXXUXLhIVUmpqUUD
         xVDn6hxdVJvpcDyJ22IOesHWnK0crJURoUdootKScdSzkDO0LPcv2JpkS0PM9kH5ZziU
         wVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012580; x=1794617380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6UdDeYYycrdIuoZVPp14+bHtZX/0C9MDOpCvhR20kI=;
        b=Q5HpeiBw28PnHCrg2zRuWH5lNHNGuhhmHomCtRv4BAACgXONj4kaRf75U3gSjYLk4G
         28JqJHsAiwGKPWk90EaaHzZ4RfakFUsYPIJ+dCuBkNz3hS83xT5hx6UEDVKXqvDF2fNn
         suzIN/HKl0Y5LSfA/my7HpkxCuEqTHLjjrswFyDgN2b9z3oHkncJ/OadEYE3Ykm9z5VC
         ZjK/cawKe9MlX7FY5qgNUeIFbPVKRhc5aBub3q80xCgYiLpUchpQ0Y7yk++z/N3facki
         8wrIvCUZaknMzo03RQfAz3SUK7AoTgoEAU4jApio6pMMHW8mQZLfEAUB/kPVFsIwWU16
         7Mvg==
X-Forwarded-Encrypted: i=1; AL+hErFC9yEF5AmE0CyDg9OZIjkYmyzgGFMEI/ZoBhgTli0aBHU1zFzP5PfaqWbMgZ/vvnABw0HkifKyI2YvfD+JYw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vl7MC/kY5dqA0TmjgAGmo+UJWyRkCRjM/LExBPXuhHZphC4m4
	wOOcgSbg/LCs6hWixxob/1UujH1hkP3/mgSOs4J6Hcb4cmq3hiVQLxFhpcDmY1bm7gE=
X-Gm-Gg: AYBFou0mSQgH7DKoypks6IDeRf4vzgs8ueUSzGUaYzl5lLZfGSyG+y1BIRJrhSGMBvj
	sOATvthIlW8GOeXcYYSDPRJvmMV6gJ6yFiQMLceds3RhHnsJzQ7l6oReOLPHdfBq2+wlA4SJ39F
	rHYH11T6YOu//roG4X5XBcl5PeEXPVHhN8kPpLdkeSMVDv7aWiHKVQRlDcHOYuJl3g9P2sAjPFE
	5hJecU5chTtFXOOjjJRR4MPRsc0j4lhNfUeqUaoa/bOv5viNcJLKVrKmgJ7jGPXlugtm7aAu2q1
	L8LLvbKCML4ldZU6pnOo9S7O30El1RYjGQzPqFSJmcYgee7EtzTb7Mdtrq3IIFldKsr+dfyVEmm
	US+KrtS/AoKxgq39b76bEQvg0fNpyaer2GD/Mt16M8Ad/A1LlAEdnzXh6+USSEZClWZwRO9YALc
	agt6YITTbn6rynErkyMdhqD6Xtxk2Z4b7EpUgprJKhzvN4MtRiTzwOhoLhXMv4W/MewpyPgCp4x
	V8NLY+phtaVJQi1uSLdQCrIka0w9abMBANKWGqr9g7/ExZ3eogLq2Hdl42R/NdMq4ZeKptcMl9W
	cPubLnvj+KFuqW54YAu+GcRmRTybf2l3Ut7U4yWabS3C1wnmGDEmxdU1r03kQrxaNTiMBPs=
X-Received: by 2002:a05:7301:4605:b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-36f729cfab7mr5026586eec.5.1794012580134;
        Fri, 06 Nov 2026 16:49:40 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:39 -0800 (PST)
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
Subject: [PATCH net v6 1/6] amt: stop receiving before amt_dev_stop() tears down its state
Date: Sat,  7 Nov 2026 00:49:30 +0000
Message-ID: <20261107004935.2627329-2-omar@blockcast.net>
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

amt_dev_stop() clears amt->sk and waits in synchronize_net(), but the
socket's sk_user_data still points at the device until
udp_tunnel_sock_release() clears it afterwards, and nothing waits for
readers then. An amt_rcv() that loads the pointer after the grace period
can still be running once amt_dev_stop() has cancelled event_wq and torn
down the relay's tunnels. A gateway can then queue a received
Advertisement or Membership Query on event_wq again, and a relay can
link a new tunnel from a Request and arm its gc_wq. Either work can then
run after the device has been freed.

Clear sk_user_data before the grace period, so synchronize_net() also
waits for every amt_rcv() that can still see the device. Once it is
NULL, amt_rcv() drops the packet and amt_err_lookup() ignores the ICMP
error.

Found by code inspection; not triggered.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82..3a703b79f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3073,9 +3073,14 @@ static int amt_dev_stop(struct net_device *dev)
 	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
-	/* shutdown */
+	/* shutdown.  Detach the receive path as well, so that once the
+	 * grace period ends no amt_rcv() can still see the device and queue
+	 * work after the teardown below.
+	 */
 	sk = rtnl_dereference(amt->sk);
 	RCU_INIT_POINTER(amt->sk, NULL);
+	if (sk)
+		rcu_assign_sk_user_data(sk, NULL);
 	synchronize_net();
 	if (sk)
 		udp_tunnel_sock_release(sk);
-- 
2.43.0

