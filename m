Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235760;
	b=4IzWHY2KL9LAcQgxVt8HX9Z3vrZEZ6HQlTHnY1cllxXH2Krdllitz/Elq6fbg798REif
	 EQbYJJH3pA1nZ9yQQoeW/0PrY3e3Y5PuhfvYLWmjAL5llQh4+eDEQ68WXjKMCQwRZYgjd
	 XfwtoG2QtyhAS2g/7r27MwySgMTcXlgMsuGPmy/f4b57Hz+Ckp+lV7nhnHvKipvolZeBm
	 TtNsph/CHPbLODerAMMpU+pbTm6wNqvou2AKRs3s4EfVfEkLzDkiQL20oyISSj/wBfel1
	 lRe6xBdkYyRjJB6BhnceWM0dMB19vKOzRI+gFWHBwNTBb90yB/2nKbhKx/LzWdavx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235760;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IX95xDsvyWoCZ76YedFOzBHzevTiuhph5IXIE+KtEOQ=;
	b=rT/p8WObYMhVf0VILnVt3Sx2k196gNMMFc/FzLX59yK4FooiPOp14pkbTSctj7eHcJ8h
	 GX/poOKUSrHv4ZzNXLOF/WkaXiq6eiUU7jPT2JtI08KHJ4zNZ48Mf1JPpp4sdlRXIQaps
	 3slAgDrFijwpd9NAvM5+lr/WI+F1J+K/GCr1ck5mFok9XdNJ51d2QDQesfLmXB0KuUuEJ
	 1mqBkYux3iZI2KGZdq/g4kYq5W3cqKedWTBv/1BEZHYRYghIA9t5p7w35Wq//Feqh2Wk8
	 OUwo+sCpNAF6E526gsgqY5IraRyu+EytkVpuZmFZ+Qa4V5PNXFXQTsMR6uX8GWAoMig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bv9BTYbP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC80606A339;
	Mon,  9 Nov 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bv9BTYbP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE211F0089F;
	Mon,  9 Nov 2026 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235759;
	bh=IX95xDsvyWoCZ76YedFOzBHzevTiuhph5IXIE+KtEOQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bv9BTYbPsYMAi5bjXPBcC2ylbrILZXz7K/3/EgqYT5I/vylBek0r0D1KgUID8G3Ey
	 vIKqatkyuHZpFb3dxwmPhLg0T8LeME2aqO+HFOELrB+HX+jC9mSBdPHo8FlvlrvAlr
	 TQrgRHbTBh3m2Rm4tD4XH0hiUL1mbaOys3r3SUA8AzylyOxlUS21wJg+AQPQD3A2C2
	 Kq/TOnQUAra0xgCZHbDpbPcB+WA9eJZ++rHMzuv2+GluNlcSkvYy1TlCJCLuxr0NsJ
	 +tyoZ0f2GvXu0gKO5kZOOycax+x7PXKswh8ymiSxddA2DU64eq7nCrSdcdIL0UuNiG
	 aEmivXnTw+6qQ==
Subject: Re: [PATCH net v5 2/5] amt: reject a gateway Query or Data from
 0.0.0.0 before a relay is learned
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev
Date: Mon, 09 Nov 2026 14:49:18 +0000
Message-ID: <179423575832.994134.15932403659045742824@kernel.org>
In-Reply-To: <20261105125010.1107546-3-omar@blockcast.net>
References: <20261105125010.1107546-3-omar@blockcast.net>
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

- [Low] The commit message for "amt: reject a gateway Query or Data from
  0.0.0.0 before a relay is learned" gets part of the root cause wrong…

--

amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned

This patch adds a !remote_ip guard to the Membership Query and Multicast
Data source checks in amt_rcv(), so a gateway with no learned relay
rejects packets from 0.0.0.0. It also rechecks the packet source against
the current remote_ip in amt_membership_query_handler(), which drops
Queries that were deferred across a relay address change.

> A gateway's amt_rcv() admits a Membership Query or Multicast Data message
> when "saddr != remote_ip" is false. remote_ip is 0 before discovery has
> learned a relay (and is reset to 0 by amt_dev_open() and when discovery
> gives up), so a packet whose source is 0.0.0.0 would otherwise pass the
> equality check and could spoof a Query or inject multicast data.

[Severity: Low]
The code change looks correct. Some parts of this description don't
match what drivers/net/amt.c does, though.

Is "when discovery gives up" accurate? amt_event_send_discovery() never
clears remote_ip. It only randomizes amt->nonce:

drivers/net/amt.c:amt_event_send_discovery() {
	if (amt->status > AMT_STATUS_SENT_DISCOVERY)
		goto out;
	get_random_bytes(&amt->nonce, sizeof(__be32));
    ...
}

The reset happens in the Request phase, in amt_event_send_request(),
once req_cnt exceeds AMT_MAX_REQ_COUNT:

		WRITE_ONCE(amt->remote_ip, 0);
		amt_update_gw_status(amt, AMT_STATUS_INIT, false);
		amt->req_cnt = 0;
		amt->nonce = 0;

amt_dev_stop() and amt_newlink() also clear remote_ip. The message does
not mention either of them.

Are the Query spoof and the Data injection really two separate
exposures? amt_multicast_data_handler() already drops every packet
unless the gateway is in AMT_STATUS_SENT_UPDATE:

	if (READ_ONCE(amt->status) != AMT_STATUS_SENT_UPDATE)
		return true;

With remote_ip == 0, the gateway can only be in that state in two cases.
The first is after a spoofed Query has moved status to RECEIVED_QUERY
and amt_dev_xmit()->amt_send_membership_update() has set SENT_UPDATE.
The second is the short gap between WRITE_ONCE(amt->remote_ip, 0) and
the status reset.

So the Data hunk looks like defense in depth rather than a separate
hole. Could the message say so?

The message also doesn't mention the condition that makes the Query
spoof work. amt_membership_query_handler() also checks the nonce:

	if (amtmq->nonce != amt->nonce)
		return true;

amt->nonce is zeroed along with remote_ip in amt_dev_open() and in the
request give-up path above. A Query from 0.0.0.0 with nonce 0 would
therefore pass every check until the next discovery event randomizes
the nonce. Should the changelog state this?

The effect of a spoofed Query also seems larger than "could spoof a
Query". Besides injecting a forged IGMP/MLD query, the handler changes
gateway state:

		WRITE_ONCE(amt->ready4, true);
		amt->mac = response_mac;
		amt->req_cnt = 0;
		amt->qi = ihv3->qqic;

It also moves status from INIT to RECEIVED_QUERY. After that,
amt_event_send_discovery() bails out on the status check shown above.
amt_advertisement_handler() then rejects every Advertisement:

	if (amt->status != AMT_STATUS_SENT_DISCOVERY ||
	    amt->nonce != amta->nonce)
		return true;

Relay discovery stays blocked until the Request retry limit puts the
device back into INIT with nonce 0. At that point the spoof can be sent
again.

Would it be worth describing the nonce 0 condition and the blocked
discovery in the changelog, so stable backporters can judge the impact?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105125010.1107546-1-omar%40blockcast.net
