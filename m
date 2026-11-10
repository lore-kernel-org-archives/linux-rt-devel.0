Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344751;
	b=f3kQuo1f1DXdXwYiAEslpDWkKb/L2TiB+k8a7GfyzdiENLgUDLlfko4+jQtcmJmXWQQO
	 q9/dsECmAb0kMbffPcReMVBHdNpAhJhuwq/ReY9ek86XhyGA8agqupE/vkup/XLn/+BZm
	 AouYKwDHxvnauIMfknbc0rXitKKpqWFUVKVXVvqcNzZK/JSl0hREDdL75NusinnmFuYoC
	 l5IDuol4GYRIzhJ4GTa2RBb7JWqYb7ydOZT2TPxYIZqQ0XtMp+t7HCohG5ch/VK5KyIyE
	 RKftacwTctV246Ll/mKjeS6QyVUokJd77ur24dCOos8KdCSjdAp8qCE+HYno6YDbiuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
	b=qbfkaWVKXEno3xrjH6Ps/4T64jIcaqb+Hk7yjnR/9qCeHTrWVuEGGvcEXIh+5gWgfhCP
	 KayIREeQZqvlG77W2TmhMeTbRqrRjeQGLQIwCUIXQbJGzBX+x4+5e7p6s5pu0mTemu1iG
	 JY+U7VeYBQEZT4oqU0rE/5PYeasncr7V+VPbhL+B6A48nIbN0vdG5ffoTl+StJzDh0atW
	 +dwICUcFWlcm+YkIdwOo99omv/IIsG503KV8xT37OHBREcQpO+9TRFuWoiouIrLmqPJOO
	 aL1vHHwcKFSAEWpdFi4k6NM1XOlE6wx7qVyzHwgG94GOyBMLW4+aUs4ZVW8283I4tfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=yEVq33G2;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094160A3814
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7094160A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=yEVq33G2
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3894951eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344750; x=1794949550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
        b=yEVq33G2C1juHe0txDxEbcXuulFfz1JEkOs7z2ILb+VUkhGqIYrdMk4QeXZOILV3RM
         HrWQ86z22f1MSxXhok5P79+PZ2R0W3cC+IfvRmeO9woc5NXaF1fslSHCcK3tf17ND8pG
         7Ie6XyVklxn5ch0RRHmk/FWRN7PPNPc7wtWJ0zPwBhbBIQEm838Mxjs+NoGly8vpdlmi
         F97lotlwMNGSNVADDsxiCeUfwn/Charcdmm8SW3MFhsRa1IT5Ususjq0q24o+LJmUGYV
         Az2Jy4zpCH/DH6x6m7xlMDoJmMEPXn9qTY2nPivI/YqEwGs7X9PVNl2Z/RXzQCp15x6p
         74qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344750; x=1794949550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SwDFBgR9w23+8ieHzLTaA/3ovrrRYj8PAKqMDU75z7s=;
        b=HTs5LrSxrvCtV+zTZVLSMXpipraIk2iqYBqSdwAYd3BOWKckCdSBGA8vPtzMMdra5m
         uUDsmXJZXfl51F1aM5gC9SKwllJ/SwSagUz/y0nFoD8MjN78anEQbWj1gcQD8wi+8elx
         tjSV8VbfcYq2pFalNxqqBi3KdhK8iN80uD2iEZybzI6HTjy2VXd/UgQzBnQ5/yRx8lQU
         +yUfsMK1JNACZkixpxa4wTTYdDbzJJre8JX0TYf9PJAPSeIrIXcrtCtJq9ycGnkezVhJ
         H7BXMEhXp6x+BtzmevVen3rvYQEClNLOZw0FoiD5cWD9wFRFs73UuWMMEACKY0e++uvz
         4Bfw==
X-Forwarded-Encrypted: i=1; AL+hErE4KXN+WpErWTyR9L229xKIKsrOOd/5M9DRe+ElyIYMcFJTlGAx8ZukS13P7p2eFGkMKsO/fIWNy2y6XOjubQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Hxd28KMTFwqNmjf+6K7xqnLX0EPhOZUIgoZPbFtLgcJIhMfSl
	EJxOwW6Tl0xpSGH+/xX0hlGBEm42/7nQsVPYlBpEaSON6zpJo6mRz7AF5uTKBwJhhdE=
X-Gm-Gg: AYBFou2lYf/ZSB1NVYZax0Mok/ZBMWSamnECQLGq3VtmsNgBwie7X9tyRplirmx54F0
	iuuhJ2RFkyHTJvWPiCCKphzwaBGgRKQSEj23kAoAh9N07RBY18klKHywOZJwLgToPYjRe+ELPks
	mloBzuy5Y4voavUo0m6z4c/YbAXfix8HOLPmSRIpTJmKCIftvItWtNfohSpQ+8MsgPzEhUm1IuY
	IodTfJIQnoc/7f3dvLCsWYYKUtbfXLKN1WfyShua27hwrT2ZqkJN6/IR3g+MJjyym32XMBqEkvf
	YhuxauRD3bvnyDhpM7hsEtbIDoVpAXWWljHF22dE34H5+sLAjZz0mQsecL9uusOJ5PFlLnpNYjD
	AZvRJlv2UgEaH+tK76rQV9k6m0TPll1LADygtyS5nlgt4aXlMH/5L5aDbvg1vFA0xAwFmlX6WLD
	qmu2dQ0uMcsuwUDF6TdCi98q70xaLy/X/nsNFtZsRSOY9y2qmMO3xEyEMDKS1rVi2Q3FzF7mwts
	oVFjG1CJTskHrMOxN64q3RBILIPa+mKh7MnJmEwXwoz0erNot/Orskc3Fjlevbhu10U3PHDBaGK
	aB866yT5HwFL84b4QsiW037sM/PMq5P9Ewrl0zPN2L6z6cSMEx6jzND3AF43zUy1uc3xXVQ=
X-Received: by 2002:a05:7301:5f01:b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-37685a89f74mr970768eec.8.1794344749231;
        Tue, 10 Nov 2026 13:05:49 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:48 -0800 (PST)
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
Subject: [PATCH net v7 4/6] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Tue, 10 Nov 2026 21:05:35 +0000
Message-ID: <20261110210538.217936-5-omar@blockcast.net>
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
index 9f59ec6c4..99cce0a14 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3359,9 +3359,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
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

