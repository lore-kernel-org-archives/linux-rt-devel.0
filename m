Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099006;
	b=0OfrybqTwSAG/eVc3wnSaXBzGCL0zs4Z9+YnwQxxTPWkRvCirnu1CvOJK6tM4mQWVZCR
	 SyHWKlFcQoOzJ2oQqT2Hoc4Gvg/Ab8jQdAky9jsGEij7nrNaY3ARXweDSmk7mTU4m+Wd0
	 EOt9ZlUDyNJqQf0I7QZlH9rUy//cvCGEKNuuTTnB6CiM4fkZven7xwYhkqSbUVQ56SGr7
	 /mm/wGFMaaYyNvLkh+EXY0/VX2cFEvv13vRi5Cvg4bPY3/mabmR6EI2O0AaCqj6cINr5f
	 OacjeSb98mGBr0NYthuLNJeQhLxjot/P53SyqSo5i14EL7UwKqybYhGW9UKvA0Vbimg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ycBAJ5FrW0Yh7SIfNsCJabTC+sDYF8E9sGOo3X3r0nI=;
	b=gWL5KDlArsgm8CJLs0rcNQoU6S1+KedDOQE1EBlZB3WID1gdOkOddM2DDkH6LbD2P/A+
	 zjn8dNaZ5kxwkvw8YbgOjGnTEbaJN17d/rVOvyViUcH1TBaniRv3Q8r7xo1gUXGSjlZeH
	 LMnQcs4GtcfXuSF0rvd/uqq1NviLCrRF8sKrerp+8ymdjTQKQFk2xU76QZcJEEhg8DPPj
	 Hneb46MX106jzmuZ1nXljANNZPdGPNNdMIcV1PvkHzihkT77NGx3QysOkf/ZPYPVC6LnM
	 XlEtcDKUwZ/1wrMiA2MzNU0M+2SfmBxzUcxLxL8QE7OkR6BLB3hxuclhoKm1Nk0X1ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hH91j/p8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE6606A326;
	Sun,  8 Nov 2026 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hH91j/p8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111D01F0089F;
	Sun,  8 Nov 2026 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099005;
	bh=ycBAJ5FrW0Yh7SIfNsCJabTC+sDYF8E9sGOo3X3r0nI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hH91j/p8jm9mBLU0t1QKs/LdcrZWQshTeiAqbQNsHa3wndeKtCBa0Z9mbrfSIs6WF
	 pmgAwLfmgHqtF2hRFa956/5sqtKFxIkv17uFLNNCWPfR9jiTGEVhLInOsYtsMUP4kn
	 IBKk0SEJSws6zzvV/XM/clY2n11lmferDIeX8b72WvEwoqnCiG9BtEUeH8iLhDx54R
	 GCD62uT7jQooJlt0qLKJr5OgArPGrtMIk4QaRpjzE/uXXPEPAkfZN17nkCE7gqWpoe
	 pxSKMB151o5Uk4xvM3pAPA2wVChupXbuCy9H40OJ+4DGIUlwKaTv66ShWkPMsOQbTu
	 ncml3NaccwVBQ==
Message-ID: <sashiko-outbox-203503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 3/6] amt: reject a gateway Query or Data from
 0.0.0.0 before a relay is learned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Ramadan" <omar@blockcast.net>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261107004935.2627329-4-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
 <20261107004935.2627329-4-omar@blockcast.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:50:04 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] amt: wrong Fixes trailer commit in amt_rcv() remote_ip check fix
--

commit 96318be241052a6271835580e7680bbadcc12e44
Author: Omar Ramadan <omar@blockcast.net>

> amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
>
> A gateway's amt_rcv() admits a Membership Query or Multicast Data
> message when "saddr !=3D remote_ip" is false. remote_ip is 0 before
> discovery has learned a relay (and is reset to 0 by amt_dev_open(), by
> amt_dev_stop(), and when the gateway gives up after its Requests go
> unanswered), so a packet whose source is 0.0.0.0 would otherwise pass
> the equality check and could spoof a Query or inject multicast data.
> IPv4 input accepts a 0.0.0.0 source only on a limited broadcast, so the
> sender has to be on the gateway's link.
>
> Reject both when no relay is learned: a 0 remote_ip must match nothing, so
> guard the check with !remote_ip. A Query is queued before its event worker
> processes it, so the relay address can also change in that window. Recheck
> the packet source against the current remote_ip in the handler and discard
> stale Queries. Discovery is unaffected because Relay Advertisements are
> validated against discovery_ip, not remote_ip.
>
> Found by code inspection while writing the IPv6 receive path for the
> AMT IPv6 outer transport; not triggered at runtime.
>
> Fixes: b9022b53adad ("amt: add control plane of amt interface")
> Assisted-by: LLM
> Signed-off-by: Omar Ramadan <omar@blockcast.net>

[Severity: Low]
Commit b9022b53adad ("amt: add control plane of amt interface") only added
the control plane setup; amt_rcv() and amt_membership_query_handler() were
introduced in cbc21dc1cfe9 ("amt: add data plane of amt interface"), and
deferred query handling was added in 30e22a6ebca0 ("amt: use workqueue for
gateway side message handling").  Should the Fixes: tag reference those
commits instead?

  Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
  Fixes: 30e22a6ebca0 ("amt: use workqueue for gateway side message handlin=
g")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107004935.2627=
329-1-omar@blockcast.net?part=3D3
