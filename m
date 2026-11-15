Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722860;
	b=2oR8Xr8TnQC+ZGWeJkNirUwosQMaZklYZnijR3p2cBXDDMxaWvjzOL1u8FdXK68D0IGJ
	 Vw10+wIuLmubAyh7wIagvlIYlK2Tl1HL8RsbztMTZ4/OQeyJwDxlyqLRfHRdIXciOlQhz
	 iPAiWhF3rugUV7i1Gn9y6jtwZJ4ApHl2UUVIaZZz+eEN8Pr+DBP76tLOqvG8gJHpAHUNm
	 rcOYaLmOR7vcQnG1rDpy11QILTuzdPYX7SYD6uF44zSeOssdZ7J7FYcumRw3kBTvy3m/r
	 Q1uk53hAjutKcMx0dCdeUJ1ZGIBznQ3sOotZ3m5qSPK/8y/lpwWW+XoIXV+rPOpXSFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pD21cF0F7petF8iJUG6KKrG1msB1EH88t0HH2frnez0=;
	b=uy8zmxaglzsm59aGK4+rmhjnAUUWM/nbwOmYBtTjAg/XCcUEFxLHepYkwtpkcmhrnDCg
	 F6Ap9b7vFAAXIgoUdyfSB1QJcoqE5PrUIbXQgZi+yeAtnBXxJM9f2QYNkc4fj1Yn9k4JL
	 zKcAMdCoJQHKa7c0TNPBFxqVcDkREcF94wVX4VacTFGLAsN5MrmglRspkMVejvc1NuqWt
	 R2tO7sZ3Tgn9S40nbLVbFlJJWaO+/+McJ0qLkeH8yrnfnZsOpzhOSK7iPUp2RW4iqZrOq
	 YPRPDSJeIf7bkBysMLK9qkL+09RnlW3EQCURHU4xQA+G0q6iuB/xYp4s/Fp0C3myHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5DXEIp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825EB606A33A;
	Sun, 15 Nov 2026 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5DXEIp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7491F000C5;
	Sun, 15 Nov 2026 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794722860;
	bh=pD21cF0F7petF8iJUG6KKrG1msB1EH88t0HH2frnez0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D5DXEIp4EowRnZ4YvbjbQWJ2d5YtgJsL+vWmj49GKfzeugpQKCFZTauILzepfa7KR
	 tQhffYvKYBA6NowYcY5Q3pBvhU5QcQ7wZT/NQnJ7bDhsDTPUHU74ERGpyqcRZyAbtO
	 0de023lBugMB4/TLJpEb6M9H21p0fhcO+OJoZfa/mXiet/YR4eSnnKYcvimZlT/hkc
	 qksENrwAZAGeAkFVC1QM5AlVid6+mjI1yl5JlfoZawr+bjSQgi/QfHpj+bG4Eqd0Xk
	 rZpIQNTCuu3upE8f0uy/dxdO0cC35o9bHR07MFz4S2enZ9/BWAgvjZfvS2UWU7tyCP
	 liU50FScrYncw==
Subject: Re: [PATCH net v7 6/6] amt: create relay tunnels only from
 authenticated Updates
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, kuniyu@google.com
Date: Sun, 15 Nov 2026 06:07:39 +0000
Message-ID: <179472285922.2199510.7147009024477916910@kernel.org>
In-Reply-To: <20261110210538.217936-7-omar@blockcast.net>
References: <20261110210538.217936-7-omar@blockcast.net>
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

- [Low] In drivers/net/amt.c, amt_request_handler() now drops a Request
  without any reply when the relay cannot admit a new endpoint.
- [Low] The comment above test_query_egress() in
  tools/testing/selftests/net/amt.sh (lines 256-259) still says: "The…

--

amt: create relay tunnels only from authenticated Updates

The relay no longer creates tunnel state from unauthenticated Requests.
Instead, the Query MAC is derived from the source address, port, nonce and
one of four rotating secret generations. Tunnels are created or refreshed
only after the Membership Update's MAC and encapsulated IGMP/MLD message
are verified, with global and per-source limits.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index de5b7dbe3a20d..8014798b33167 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2888,59 +3059,45 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
>  		return true;
>  
> -	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> -		if (tunnel->ip4 == iph->saddr)
> -			goto send;
> -
> -	spin_lock_bh(&amt->lock);
> -	if (amt->nr_tunnels >= amt->max_tunnels) {
> -		spin_unlock_bh(&amt->lock);
> -		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
> -		return true;
> -	}

[ ... ]

> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
> +		if (tunnel->ip4 != iph->saddr || READ_ONCE(tunnel->dead))
> +			continue;
> +		per_src++;
> +		if (tunnel->source_port == udph->source)
> +			have = true;
> +	}
> +	rcu_read_unlock();
>  
> -	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
> +	/* Withhold the Query when a new endpoint cannot get a tunnel. */
> +	if (!have && (full || per_src >= amt_max_tunnels_per_src(amt)))
>  		return true;
>  

[Severity: Low]
amt_request_handler() now drops the Request with no reply in two cases:
the table is full, or the source address already holds
amt_max_tunnels_per_src() live tunnels. Before this patch, a full table
got an ICMP Host Unreachable through icmp_ndo_send(). The new per-source
cap case is also silent, and gateways that share a NAT address can hit it.

The commit message only compares silence with ICMP. RFC 7450 also defines
an in-band signal for this situation: the Limit (L) flag in the Membership
Query. amt_send_membership_query() still hard-codes it to zero:

	amtmq->l	= 0;

Could the relay answer with an L=1 Query here instead of dropping the
Request? The relay already sends full Queries to unauthenticated sources
on its normal path. So the reason given for staying silent ("a source
address nothing has authenticated yet") doesn't seem to rule out an L=1
Query.

With no signal at all, a gateway that is refused can't tell a capacity
refusal from packet loss. It keeps retrying Requests with backoff instead
of moving to another relay.

The in-tree gateway's timing changes too. amt_err_lookup() used to react
to the ICMP for a Request by retrying immediately:

	case AMT_MSG_REQUEST:
	case AMT_MSG_MEMBERSHIP_UPDATE:
		if (READ_ONCE(amt->status) >= AMT_STATUS_RECEIVED_ADVERTISEMENT)
			mod_delayed_work(amt_wq, &amt->req_wq, 0);

That reached the AMT_MAX_REQ_COUNT reset to discovery quickly. Now the
gateway waits out the exponential backoff in amt_event_send_request()
before it falls back to discovery.

The in-tree amt_membership_query_handler() ignores amtmq->l. Setting L
would therefore only help third-party gateways unless the gateway side is
also updated.

> +	mac = siphash_3u32((__force u32)iph->saddr,
> +			   (__force u32)udph->source,
> +			   (__force u32)amtrh->nonce,
> +			   &key) >> 16;
>  	if (!amtrh->p)
> -		amt_send_igmp_gq(amt, tunnel);
> +		amt_send_igmp_gq(amt, iph->saddr, udph->source, amtrh->nonce,
> +				 mac);
>  	else
> -		amt_send_mld_gq(amt, tunnel);
> +		amt_send_mld_gq(amt, iph->saddr, udph->source, amtrh->nonce,
> +				mac);

[Severity: Low]
This isn't a bug, but the comment above test_query_egress() in
tools/testing/selftests/net/amt.sh is now out of date:

# The relay sends its General Queries straight from the receive path, in
# the same context that found the tunnel. A query queued on the amt device
# instead could outlive the tunnel it was built for.

After this patch, amt_request_handler() neither looks up nor creates a
tunnel for the Query. The daddr, dport, nonce and mac values are passed
by value, and struct amt_tunnel_list no longer has nonce, key or mac
fields. The check the test makes still holds, but should the comment be
updated to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110210538.217936-1-omar%40blockcast.net
