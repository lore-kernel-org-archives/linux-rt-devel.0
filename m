Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012587;
	b=oA71JBzVjomD4UX+LNcd4dAdUVgLBpwCt1elmqUGlHe/EoHM4w+pZQJkgaOf9GkDpkG2
	 gWAb9XhaMU7RYkZyLzNV99eosdFdaaxu8CkHVzYKankIolvyirn6BCE3hbQsNTdCfTanA
	 MdLRtYx5KWPaLruZ0gsKV7AruRugpQo4zCbPR7q/RVi4Kr0m/C2sZT33ahkgKqo3DU05J
	 i2J85BJQUcEYVF30pJKd04bN+TpY2GsshMRe4jl8jJv8Rez9smlsGCBBfj5GwaAF7OoJJ
	 jNMtLcTKM+FliI96HS5fgWzCVYY8pHuNiI76L0JIiNmYERPez2p5xfL6X2KtFfOYRJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
	b=18peEYtSjTzq8T8+O/pG1uLUHlA/E6QhcU9/aqGu8CzRMZylExhN5DpeoSkJ7zB6JUOc
	 ueDai8fbS6W7rLG8HdUtvlwgbzqgjtcABd3WmDqy1Fk8W170jcDws6C9zHcbHaBIt45eb
	 mlYRE0QCvnoiFJveqcnfulvnqpfjo6ghxZW5jqcM82SuLQgIwUz9bXTiSuwbUIVuiiDvz
	 oTN8Yq510Bnd10rCQyahp9is8A6Z89Upn/6nzfUhriuGXvgS+A3jf326cUp0MQu90KgCK
	 i8rB5ULOVi55g7+0FkFk4Qpe/6zOPEvZaXPhfE+MACs+f174BMsDZtWaDDZNyzMrnwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=T8W7yRVW;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651E60733C6
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5651E60733C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=T8W7yRVW
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1953232eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012586; x=1794617386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
        b=T8W7yRVWXb83BMOox0AfA/K1ftpnKdI8nAjtQyEF3MIMaPmP8HN1J0UK582tBfwTcc
         Iq4DAD0uFVChGeOQqCr9qiLtFAKbP6GU7M0P6fBDUhKN/X0psBbb6wJc/CupliK9END7
         S9BvbOzZUQg6XZbKlk064XCEwv7PbEfIGOyy2pkFtcBF9k3GGcb5kFImlbAJGcs3zcD9
         oR1QDoURp8lELj8w/bLz2I5OVLWJBfm/RY24gfrNxgDqDzUqQ80Ggmwn4vR/VztRE1OQ
         pF/aEqFNkH6fbyAHEWTMyUJ/Cfp7XGM0aj294FyaQldWjkwUcDRIGPiyEkVd65sCFxg6
         3X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012586; x=1794617386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
        b=dv/PPv/Ke1+eWiSvhTY2UGucFo/cw3ssSjm0f0BkGyI1eMOCb3ES4At+ImhhQwQBgN
         8VFayFXuBtlrpsYIEdmscXOmso9ZAdj5y1GbovEIGgmWcGRw8E5Fi76P0r4CaXhNyEHt
         OHRd+4HKtDZp7GUnKGHjjeMveV1U41ZM6DhVcxF+W3WVCsNh1KbqZbrK9+Cib1XAlGnu
         RUI36+jN9DV1vBM/qk7PZw0g4B0rByQE4IvrlAqN6vOqOVsczKj7wdElOW3oARvFJuaz
         6rsVLzYw5OlcWcFbs+BGPyD/VuOdNMDbk80OjmKZx6lJBtq4KDn+t8w53IVo9K9r/fBp
         i2/g==
X-Forwarded-Encrypted: i=1; AL+hErHrHN4I9qqjL/yewZkqzKUf1jFSxotXjZIeSu2GBfJp59IPqO7tX3cuzBSoeHNMfPrehkXJ3ne7XvFRN51xiQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1bsvqjQKWpSoG8dZJCGjI1rzDHGe4Qztjl3njcWsqGu0QLIZb
	RIt1FKZLM2UD5Mle0EfO3oQ49m9joLP3Ye8oOv9P9rT4IHShg8WxZ0Hc/SpgmRS0A9g=
X-Gm-Gg: AYBFou3HVPnSWn7UR7KhUZPL6dI9M3LGW5lWFUgxKOrqi5hHoBy70cuafEylwMWbSt3
	thZON1XkfwVGC+rNo9IYPQbo5DvUYKCSulz6/yKEstHb2ZdiB6VvkeE0FcBUvZLoTtiWS4M5+el
	/jViDbFb6VvyEt8bKT14Nnkba3g/hkdGFl3wgrkK/DolzwEbdiGSJGFuSmIKVrAYuU/PoUsUZgc
	O/Y55c/f/ZTtDEZsFYG1a89e3/yKRW+bDaMk0Nhh6KZ2JFhMp1dV3+dlQlzDdUHXfC8/BceNUUC
	uH0UCHKR3G/CCKb00IZv/DiuopOvvoGwJ3kz/SE7I1/EehW8KAAxW/Mhnn5FN23ssD6dQHU6xTW
	3teMCkAj5q9esOysfg+Hytek8PaaknuWabj4SEajwgbZFKwMYv+ao2KGjN9OS1BHLqe4+fN3NhK
	lVB923WtxHO6Hx9Fck2sRDmZcys3YpcOJVHUfpxfbelNsjn2pIxhw6PiSXs9JYXuPxZ460A+qq2
	a7KDb/hsBiq6faJuq5xaZfk16//KF/FV/vpSCAA74xSoxwArwrtxv2hRpMkHJXrcBy4ZaAN0PjR
	Ov+e9HECVKkeLRMoXFxcq4JJm+ohNfNkjDf18BbXj7fNrZbt0dFlDjQF8cqff31PS9AyAG8=
X-Received: by 2002:a05:7301:690e:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-36f76815707mr4993084eec.10.1794012586359;
        Fri, 06 Nov 2026 16:49:46 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:45 -0800 (PST)
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
Subject: [PATCH net v6 4/6] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Sat,  7 Nov 2026 00:49:33 +0000
Message-ID: <20261107004935.2627329-5-omar@blockcast.net>
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

The netlink policy for IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP is an
untyped entry with .len set to the size of an IPv4 address, which netlink
validation treats as a minimum length only.  Any longer payload passes,
and nla_get_in_addr() then reads just its first four bytes: an iproute2
that puts a 16-byte IPv6 literal in one of these IPv4 attributes turns
"2001:db8::" into 32.1.13.184, and the device is created with an address
the user never asked for.

Use NLA_POLICY_EXACT_LEN(sizeof(__be32)) for both, so every payload that
is not exactly four bytes long is refused with a standard extack instead
of being truncated.  The range check this expands to fails the attribute
even under the liberal parsing rtnetlink applies to IFLA_INFO_DATA.
amt_get_size() and amt_fill_info() already emit exactly four bytes for
these attributes.  IFLA_AMT_REMOTE_IP is only ever reported, never read
from a request, so it is left unchanged.

Triggered while writing a selftest for the AMT IPv6 outer transport:
an iproute2 without the IPv6 attributes put all 16 bytes of
"discovery 2001:db8:a::2" into IFLA_AMT_DISCOVERY_IP. On a stock
kernel the command exited 0 with no error or warning, and the device
came up as an IPv4 gateway with discovery address 32.1.13.184, the
first four bytes. There is no oops or trace; the symptom is the
silently wrong address, which fooled the selftest's capability probe.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c714994ef..6d5d43b48 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3331,9 +3331,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_LINK]		= { .type = NLA_U32 },
-	[IFLA_AMT_LOCAL_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_LOCAL_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_REMOTE_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_DISCOVERY_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
 };
 
-- 
2.43.0

