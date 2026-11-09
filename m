Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235763;
	b=VkeriM8Wpa6UKZVLJe/3AKdayOLdqHEijGZPruehuQ/53UmyS5MkFbvHKT6mZkiVoozv
	 klcomTymV4US15DUx/cfMVjzOOBf9leEWsn4I3lPp6ityk/Dr0CdC8MbG5bHuZWDsZsne
	 r3rA46J71l9Axkxq3AcU6ZfL7fZr5eRChNdZoWS3/FqE1XWaoiPad2G07nDcwPJkPtsWA
	 ltoXEBGRUkJFpuGWFYpXxBMTzjkOjzkw2lrkWUKTfopvo/bEbrPI9fPg2NcVd3VRfqqCm
	 9bq1o5ZXivvrGbNj3HrfZTysDkvOeGJc3+LnQTFQKdzrDTzV40yv4ptMzwYItsJ2zdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235763;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gH6ldD8h94PEyI/fVVqy2zum25OGPnjEUR2wKK3jY6c=;
	b=lj1iG0zpyirFfQk0KuQE8+bVo4fGeE3r8+BuoPJ41l+vAzpixB558KaB8Zasuo1SIJ5Q
	 0igZUkIU25IHeC8QbNslBeV5k1F1r/woJ9A2yKWDO4mxv0Dfc6buptZynJd7MnqrfL6/9
	 fxVv/8o+bD2AaqQsAA/JY1riP1KMQxEkXz4tea5VNq1vZPEgpEWM+0PXeBs5M/3EcGkwd
	 yo+JplIjnM/gZv3ST3IlqYSq1UvsG7xJiFKfrpuVzKEnyzP314ya5TJLhRnnnk5UvKJpR
	 nzZtb/LVySH4C1M7QnPbY3rqaaLsyRNqX8n0aMjpWfjzIXZyVNl8lpAVZjz/uXxhSVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RZh/2TpP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA85606EEB9;
	Mon,  9 Nov 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZh/2TpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DE61F008A4;
	Mon,  9 Nov 2026 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235762;
	bh=gH6ldD8h94PEyI/fVVqy2zum25OGPnjEUR2wKK3jY6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RZh/2TpP+pZnXBnGrUO5i0q2EOtpkHrC/0w8x62IAxn9LaVI1+5LPQfwUnewgXjUV
	 SZr+jBm0TRpaNn7oCS+nMTNZWQAlzzf993Be4p2tqg5qiQ3QaVSIuep5hAaiLlo8iQ
	 MOHJnP8832qBduKpquHW6ozuSUsIY3MO8F67ojN3PeZvpPfopcNYUBooF+Kn5jsrV8
	 zTdEmSDHRk2Il6JHic/KjF5IWUm9gXA+FawalMOWV/eP3C71C8PqkVpD/RrgoUwdkC
	 VetP4udLsFyGjnknfGeCVIrqOeX663T/N0QsylrqY5CFGC2lWBC32rs0aEueip1pJb
	 skt2dFd15SQBg==
Subject: Re: [PATCH net v5 5/5] amt: harden relay authentication and teardown
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev
Date: Mon, 09 Nov 2026 14:49:21 +0000
Message-ID: <179423576119.994134.11181391213411379311@kernel.org>
In-Reply-To: <20261105125010.1107546-6-omar@blockcast.net>
References: <20261105125010.1107546-6-omar@blockcast.net>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes several security-relevant behaviour changes
  that the changelog does not state.
- [Medium] AMT_MAX_TUNNELS_PER_SRC is fixed at 16, but the global table
  size amt->max_tunnels can be set by the administrator.
- [Low] The subject line says "harden relay authentication and teardown",
  but the patch does not change any teardown path.
- [Low] amt_request_handler() takes the device-wide amt->lock with
  spin_lock_bh() for every Request that passes the header checks, forged…
- [Low] The new comments on amt_send_igmp_gq() ('the requesting source is
  not authenticated yet and no tunnel state exists for it') and…

--

amt: harden relay authentication and teardown

This patch makes AMT Relay Request handling stateless. The Query MAC is
now derived from the source address, source port, nonce and current
secret, and tunnel allocation moves to the Membership Update path after
the MAC is verified. Tunnels are keyed by address and port, with a global
limit, a fixed per-source limit of 16, and four secret generations
protected by a new seqcount, amt->key_seq.

> amt: harden relay authentication and teardown

[Severity: Low]
Is "teardown" accurate in the subject? This patch doesn't change
amt_tunnel_expire() or amt_dev_stop(), and the commit message body
doesn't mention teardown.

The only teardown-related edits in include/net/amt.h re-word the struct
amt_tunnel_list comments on last_seen and dead. Their meaning stays the
same, for example:

-	 * tunnel first; the other then leaves it alone, so it is freed once.
+	 * tunnel first;
+	 * the other then leaves it alone, so the tunnel is freed exactly once.

Those comments were added by the earlier patch in this series, "amt: fix
use-after-free when a Membership Update re-arms a freed tunnel".
Re-flowing them here can make backports of either patch conflict.

The one code change related to teardown is the new netif_running()
recheck under amt->lock in amt_tunnel_get_or_create():

	if (!netif_running(amt->dev)) {
		spin_unlock_bh(&amt->lock);
		return NULL;
	}

The commit message doesn't describe this recheck.

> Keep Requests stateless by deriving the Query MAC from the source address,
> source port, nonce, and current secret. Authenticate the Membership Update
> before decapsulation or allocation, key verified state by the address/port
> endpoint, enforce global and per-source limits, and silently reject an
> endpoint that cannot be admitted. Retain four secret generations so a
> gateway can renew its MAC across rotations.

[Severity: Medium]
Should the changelog describe a few more behaviour changes? The patch has
a Fixes: tag for net, so stable maintainers will need to see them.

First, amt_dev_open() now seeds amt->key before amt_socket_create()
instead of after it. In the old code, a Request that arrived in that
window reached amt_request_handler() and ran:

	tunnel->key = amt->key;

At that point amt->key was still zero on the first open, or still the
previous key on later opens, and the tunnel kept that key for its whole
lifetime. This is a separate fix, and only an in-code comment explains
it.

Second, tunnel->key used to be copied once when the tunnel was created
and was never refreshed. Rotation in amt_secret_work() never affected
existing tunnels, so their MACs never expired.

Now every MAC is valid only for the four-generation window (180-240s). If
a gateway doesn't send a new Request within that window, its Updates are
dropped as "Invalid MAC".

Third, amt_update_handler() used to accept only the nonce from the most
recent Request:

	if ((nonce == tunnel->nonce &&
	     response_mac == tunnel->mac)) {

It now accepts any (nonce, MAC) pair minted for saddr:sport under
key[0..3]. The replay window grows from "until the next Request" to
180-240s.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 26a942c2a1267..312b36b54ff8e 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -857,11 +857,16 @@ static void amt_send_request(struct amt_dev *amt, bool v6)

[ ... ]

> -static void amt_send_igmp_gq(struct amt_dev *amt,
> -			     struct amt_tunnel_list *tunnel)
> +/* The destination is passed by value rather than as a tunnel: the requesting
> + * source is not authenticated yet and no tunnel state exists for it - see
> + * amt_request_handler().
> + */
> +static void amt_send_igmp_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
> +			     __be32 nonce, u64 mac)

[ ... ]

> @@ -1198,9 +1216,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
>  			    0);
>  }
>  
> +/* Send a Membership Query to a source that has not been authenticated yet.
> + *
> + * No per-source state exists at this point and none is created: the nonce and
> + * the keyed MAC are carried in the Query and recomputed from the Membership
> + * Update when it comes back, so everything this needs is passed by value.
> + */

[Severity: Low]
Do these two comments hold on the renewal path? When a tunnel for
saddr:sport already exists, amt_request_handler() sets have, skips the
admission check, and still sends the Query:

		if (tunnel->source_port == udph->source)
			have = true;
	...
	if (!have && (full || per_src >= AMT_MAX_TUNNELS_PER_SRC))
		return true;

amt_secret_work() and amt_update_handler() rely on this periodic Request
renewal, and on that path tunnel state does exist for the destination.

The helpers work either way because every input is passed by value. The
comments still describe a precondition that the code doesn't enforce.

[ ... ]

> @@ -2586,16 +2610,107 @@ static bool amt_membership_query_handler(struct amt_dev *amt,

[ ... ]

> +/* Look up the tunnel for a source whose Membership Update has already been
> + * authenticated, creating it on first contact.
> + *
> + * This is now the only place tunnel state is allocated, so amt->max_tunnels
> + * bounds the number of *verified* gateways rather than the number of
> + * unverified Requests anyone can send.  A fixed per-source cap additionally
> + * stops one verified source address from monopolising the table.
> + */

[ ... ]

> +	if (amt->nr_tunnels >= amt->max_tunnels ||
> +	    per_src >= AMT_MAX_TUNNELS_PER_SRC) {
> +		spin_unlock_bh(&amt->lock);
> +		return NULL;
> +	}

[Severity: Medium]
Does the per-source cap still work when amt->max_tunnels is 16 or less?
amt_newlink() accepts any nonzero IFLA_AMT_MAX_TUNNELS:

	if (data[IFLA_AMT_MAX_TUNNELS] &&
	    nla_get_u32(data[IFLA_AMT_MAX_TUNNELS]))
		amt->max_tunnels = nla_get_u32(data[IFLA_AMT_MAX_TUNNELS]);

With max_tunnels <= 16, nr_tunnels reaches max_tunnels before per_src can
reach AMT_MAX_TUNNELS_PER_SRC. One real source address can then send
Requests and Updates from 16 UDP ports and take every slot.

Once the table is full, amt_request_handler() withholds the Query from
every new endpoint:

	if (!have && (full || per_src >= AMT_MAX_TUNNELS_PER_SRC))
		return true;

Legitimate gateways then never get a MAC or a tunnel. To keep its slots,
the attacker only needs to send an Update within each 3 * GMI. This
contradicts the comment above, which says the cap "stops one verified
source address from monopolising the table".

The cap also doesn't scale with the table size: two addresses can fill a
32-slot table, and eight can fill the default 128.

The commit message defers a configurable limit because that needs new
uAPI. Could the cap be derived from max_tunnels instead, for example
min(16, max(1, max_tunnels / 8)), which needs no uAPI?

[ ... ]

> @@ -2841,59 +2988,41 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
>  		return true;
>  

[ ... ]

> +	/* Snapshot the secret and limits under the lock; keep the endpoint walk
> +	 * out of the lock so spoofed Requests cannot serialize relay updates.
> +	 */
> +	spin_lock_bh(&amt->lock);
> +	key = amt->key[0];
> +	full = amt->nr_tunnels >= amt->max_tunnels;
>  	spin_unlock_bh(&amt->lock);

[Severity: Low]
Does this need amt->lock? Every Request that passes the header checks,
spoofed ones included, now takes the device-wide lock. Before the patch,
a Request from an address that already had a tunnel took no lock at all.

The same patch adds amt->key_seq, documented as "For lockless readers of
key", and uses it in amt_update_handler(). The full value is only
advisory, because amt_tunnel_get_or_create() checks the limit again under
the lock.

A key_seq read loop plus READ_ONCE(amt->nr_tunnels) would make this path
lockless. As written, a Request flood on many CPUs contends on amt->lock
with amt_tunnel_get_or_create(), amt_tunnel_expire() and
amt_secret_work(). That works against the comment's goal of keeping
spoofed Requests from serializing relay updates.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105125010.1107546-1-omar%40blockcast.net
