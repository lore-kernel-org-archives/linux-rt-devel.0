Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883018;
	b=Bltiwh1C9aEg+PX4wHzj7FGUwmJqzCcvhMb/rAZNtyLT+q6WqicnjEsk7ehgJ28KZXWd
	 dPCRf8+QLFIkLtbXk7+uYAUxB+XcRGnLlVBeZWlQ0UejqWLh5gX6dLeGfStMwM6wHWWJK
	 Esn/pcVTPsAknU+IH5pm7OeL79a7TgxGws0gGQ7YONNGTvWkDL9ejwyLchMoYe47rhOBl
	 7KPcCJd72sALrFresFqXQiAW3yZcbvO6EpdPfJjbpHVu8D3rxoqGckoS6Yg2R5JvyzCxO
	 nc+T/iDzvyFshttR5kjdoyD0dFmqyibVQ0cKWdq0qaLQLDZxaUu2SX6JJ0DwbcDNmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
	b=iapMISe0WNPbGhA44rd8+T2GjuTQ1mat3a2UG1fPoXTmRRo55UE2magzgiGkkez6De8I
	 NopeI+qJdlNhR3c8Eg3Hsml0rIsHEmIERR5W2V2lPOIbRf5tq80sxeAa4MukrmpmrlDk9
	 YHlXYpXQyykvKdp48JY1aqdkXHxbmPSN0z6deQTmj7KRtQi9oRmIKMiBHOWvl2G3VkDVY
	 4EeOnCYGVS0E722q0q1lTc8m8rwDHdPgjAAYx9lmbcuRR/E9Zn/HU7pd3lFvo8A7bMFnf
	 1ABhMeFlVaXooKT9r2+jVhX72ddm/TJHpiYIFLbQjtcLIZ0pz+ZJ0uPW4iXOcAAAWMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=FSrTCwLg;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B79606A33E
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 12:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B79606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=FSrTCwLg
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a315ed211so727687eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883018; x=1794487818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
        b=FSrTCwLgrTSpj7iTLIqCufVxJfjbX+zzGBgLMjru0fKYLNozgJ7YPof+664Im1RQX8
         a2MJlfenn+//0Q/lBkRgLOnbKCH23MTozV9fxzpHMPd6M4eNwU3yjtO9+cj630bVm1iK
         Iy/7eZYy48otw6YAUZUZjjysWD+NgX6JGT8vmiFoac3tUdmJyvfuGXstZuYJBixQFkWQ
         MKiCvW3CBFbxzjoLzKmb4iIs92PNBFjao+EHmFozUTTJQuM+6/JSKjmGpWJWA8jpxvRJ
         zEndEeHMJGcBosjuZQ1g74qlQ6n3Yz5bYnVybNgukGwdoiE5Jqc/63TGAl6vnykGCBEA
         pjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883018; x=1794487818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdyiRLv7e1N7dBqCXNkMCcJEXQWJI7RZIXVTawyjL7E=;
        b=lPYrwjJ/ZXc/YMlMJCKR/epPAQFsj2a8RTUMx/W0IR4r9yeoHCanfs7Qp2rtGqBPB1
         nRhsuzM7EAcRYtKnuj9PQXSus09ukY9aYbdxmY9yW0codxtJSac5BmDwY1jpBgpkEpYx
         Fs7d7O2X3SGsPwdgZvOreThMg2lT1Iem0QVg6cGjVGJUYFPD1UfKZjK0L+NKWAgi9dct
         tFkA7F43JBYmUm9k+ga8alJP0pUZCQAIhrbAc/gwwDiDgXL/7Y7NNO6Am9uTg+b4TNsn
         QpOLLNs69GiwJi2R3FTakERxCPYVg2cbV4oEgc1WZ6FjkVfRjVsW3k9wGV3zO9b+bAUi
         bVFg==
X-Forwarded-Encrypted: i=1; AKwUvBw/e5nK8HFHW3U/6Zh3NrUcsWAY+rOr3fK7GXuTOfF8QJjT/dmaXNkE1HWNPEGusdtBL1/xtJnnCfUHG0NIEA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8CvOeBYA5rSQpxKeq8x44rysB6mxP0/0KkzAmVDnpONOpNZc22
	wis/Jgel/GAoQWQm0QR9svF6Ys5Qv3KKKa88mPJLZ2HKxBU7gMBMjjfe2zUXzN8IMh8=
X-Gm-Gg: AYBFou0gMEDbB5DGTKavjclALRqUl/dB/2XSK2K11V51qfvHertNv1Gc2fHlol3sG9I
	4yYZcLZVHMnZYdscPqMqn9mHHxGRDx39FfgCLt0cIfZswU3yZDQH6rVwntdj4FRoo7/Bd/6nwWW
	bYWdigZxJ064NSvY/Z40bBefPJbeSiUqo1o4h7ADkCEFtWaL6JYWCD714XtHx296NmpPlLxNGva
	8uQIpi2ez7yYqnYuMi6BzCsAQ0JpuyNfhkavKFCuDyJ722zc61zkIGaG2BKVCbWD/XUcgsQtThq
	64ntYRYyU/9i77vJwwbzJuWXwdx0GeQeltBEXwObfd8x4b3VMUIScD3iZoa2clekFcwpY4AzzvB
	IfrHiasSEpaX0ahhxx3M3PiTXZGohTUiw2iDNw6GJBuF8mJ8SUK+fbt75caeKFKA4GUIIhDSWdN
	a32cqiIxDl4cZUgWpJADpsM9HJw7LQ7YzSxpcCssxfe7uaB352kZpjK7b+TmnyDYOrJnK0+QArP
	YrYLzrYgOWUDCZEntKSBYMbpbgIF5VRPltHPq2IxFVDuarkhx/2dVVbZszl3FTsq7ZdZfAXUE5Y
	BDkJ07FCa2biy0N2y77WHRmtjilLMhuWCf12PjZrAJBFf20g1zR2f2+tcwvWi3/Zli/PTgM=
X-Received: by 2002:a05:7300:8a99:b0:36d:dcdb:70c5 with SMTP id 5a478bee46e88-36de713aa2cmr3426944eec.20.1793883017458;
        Thu, 05 Nov 2026 04:50:17 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:16 -0800 (PST)
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
Subject: [PATCH net v5 3/5] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Thu,  5 Nov 2026 12:50:08 +0000
Message-ID: <20261105125010.1107546-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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
index dacfd5524..68f08f5f6 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3307,9 +3307,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
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
2.47.3

