Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344745;
	b=Lo37JZzazVafZwlKIGQu0YqqTCLcm/otnziTayW+m5lr6nFkZ2ANcpp9UX2QHpJLIyQZ
	 7ULzYNvjKqSEGvrmuPqa2DqRQFhw5vScvnhAGqBsdxp4IQi6CuvgH3dJxSQsz5FFwg1+Q
	 roDiZC0let9VtjkH/H/DZiicc2VvPQ20YlsGX2yjseBHTsvfhSTCjMiVkxng9eJzms5lc
	 u5tREGERGkWq8tqaBjoZCYra43gn8zsxbss+qq5aCX3CslLtA98zRWwmKVu46WzULm0Jc
	 1b8CilwhNh3cOPpu5RDG9+MAOLASyIDj6h70lsx94eOE/68s9cFnW2A6P8rsvwZKCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
	b=oYJpj5h/ngP03V2vrk7EIg1T/2NLaauPcDH9XMXwyOnvWrRSULywqIzzSrJIV0vNahAT
	 BA9DaUaShdLj52Rs9noC+Kd0f8eWqzq4Lsmi+u6SC55WZ2npbZ65T4Fnj/z2cDTycL7B9
	 AIJqJlHESVAfoNFUDWj35FR8NqPkx1trGyY5ql2MDIwz2jvVaB7cF56Ea7qBLPUj/E1Io
	 3FyernsRYiQCGpX/2snVllK8mpYPqp6uMexyeg7khvM4F1yQjriiCiVCbYtJ3zMs5FLoM
	 bSc0WWpB7Tr2gu6o1x12m9pQxRMwfJqKGABWwhGHyRequKx7fO+dhnXIaWv3VzABwWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=aRIt7wxi;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36601606A33D
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36601606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=aRIt7wxi
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37071c0f42aso4373770eec.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344743; x=1794949543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
        b=aRIt7wxiMZWSrwI6pDIjuFQMUP1EFQpQxJwuLu5rNbcxVj02rkF8a3aTks8+9L/Baz
         xpKiqemDGD4cdiMGrHvE+oahxRrgXdsE0pWbhf+v/f5R12qaD+OibPQ9+lqRcqYYgLia
         beDPT9GjC8gBiJdjPRbgXj20Ym0INgrfPOlu2ZC+5Nb44xzwAG6SF5CU+5Asjj517daO
         YWQTHq0YfZJrQKsms7hD7VfwcHCc0LH89zLbvIyvAntNPwBJoDuR2j9Gz5htWma7lNdk
         4Qc7FedUvl/bHI3vQ2G30vhUQUq+1eulsqwi/EADX2VsnXUNzMMuvPosGZq6smxLr11W
         JKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344743; x=1794949543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUZ++lOPZU77n13Tlx+PO5BBZRBL2APmrbLQHc5pOjI=;
        b=cibw+ntDl/T125z9h/9koafT8nOF1IL3IDQloT0gS5nuzE40cbo/spFZazIYLWjbm4
         eUFHtnPLbNia6Z0gErkhL95H4lIlE130tUIr1AqJKfoitZpazQWxeX6h1KNWDYy2J/Ze
         4l3anbMrbV/6K51cAHTZet4nYrCJfTHRBPz7ubYgVauG7Y/BC9nqV/dgrZPEjG/k5gWv
         ffpXXouPHRq4MEJl90jQaAUBXvvPvThF8bkqLRhVo3xCFE7g7+eLm/OqxkytaSqvg3DT
         k6wgoAxOaBKwAFuEt01RfDn3leyI1HM9MUrmDMaG+OKY2H7yi0eSYT3Uyisv5mqAGG2d
         Di3w==
X-Forwarded-Encrypted: i=1; AL+hErFkX8slIp64zCnwoClgGP/HqgDxDT1KQ4xBpmLCgxb8sBOFIH6TqqXiVb8Dy5qSlSl2Wmu8ehr7/DrzLXn/vA==@lists.linux.dev
X-Gm-Message-State: APuU4Z860kAyzjaLLe+kt4ZeSvZ/0FfSIarsVxJlk5ZLOgkejnkef0Ag
	jjYuUJ08DSMdJ46xmnPp4lhfXXLcf/G+xLLVM3qJEXP1HgIhUvWwwgVyhenkn+Aq/spkCskvukD
	cF5PoLpMF8L3x4oo=
X-Gm-Gg: AYBFou2FfrPiabyNsvPkDIU/Wv16RBOTqco/Nkn4VhXHeLL0ltw8Y5ZvXiwX3PWLNr7
	x1qrFjj8iajSAFe043k40NK6LvQXVhYUVh6Eg33i+jCABdwxNUfpaNXp+ihXKBViHrdVsbzW/OR
	NmHg26Dgx5Y+dP8PQxBszHqMQBnhtrMjQf2UFhrZuaeHsi1D7IAh1sCkCdk5krT4nr+16tZNQmC
	9NK6JOEpbDkafQfMW2ggefAp802aU45sSFjIfrFpU2MGUr5LAf06najWb48fqDH0f/cBiShNQmW
	dry7jpXP0YqGDqrhfgNoewrIBSStmu43rLvibqwvGTJ+TF4+Zam1dsKzwhe2L3MuNvKipSheK+x
	ZAY8MdYB+NpqGwZfRN4XE+VyL8Kmnhi4F4K3eHXo7N/na4wcNYRlYSIm9idJbXFN1BSpiQqrj1B
	Q7bcgBdICEIx0L0nPN/0Gb96N6fKv17kTKYqDD5vqJOz7RXVMiy8hZWcLayerMqJChFu99j6n/Z
	duV3mueDL14kkumOITi0S7XmrsrASZW9DdA1GoYTixCX7TLldEnrRo3nQY64NM2eyjOdueJNziq
	BF20DgCRWgEwySv/v8RlM5Ge61nXTO8PXWEQJXsogy+1hQ7OjVPPrq6ZZHplSlXhlSnjuoM=
X-Received: by 2002:a05:7300:51c3:b0:36e:d060:8bad with SMTP id 5a478bee46e88-3768385dc4fmr798043eec.5.1794344742492;
        Tue, 10 Nov 2026 13:05:42 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:41 -0800 (PST)
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
Subject: [PATCH net v7 1/6] amt: stop receiving before amt_dev_stop() tears down its state
Date: Tue, 10 Nov 2026 21:05:32 +0000
Message-ID: <20261110210538.217936-2-omar@blockcast.net>
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

The race is as old as amt_rcv(). From commit 3cf7203ca620 ("net/tunnel:
wait until all sk_user_data reader finish before releasing the sock")
until commit 72d3b9a4c2b1 ("udp_tunnel: Remove synchronize_rcu() in
udp_tunnel_sock_release()."), udp_tunnel_sock_release() waited for
those readers after clearing sk_user_data, which hid it. The wait was
removed because each tunnel driver frees its fast-path state only after
a grace period, but amt_rcv() does more than read that state: it queues
work and links tunnels that amt_dev_stop() must already have stopped.

Found by code inspection; not triggered.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: 72d3b9a4c2b1 ("udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().")
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

