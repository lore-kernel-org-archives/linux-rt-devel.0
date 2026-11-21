Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223492;
	b=XATWP+ig4V/qUHWMFDHC1xhRSqDdw85gtDHAS7f30+GaeGJGm8SmUpSdpEIfXEZH5oKG
	 5BFQMBBfeV8k9lM3ju7FwcSJCcdo7nsqIJku7aAfwawLizF8Od9AMLplp9voyaE+2KA1G
	 1AJze2SsjYSzqPQTNhlADW33e53CgkUbGVJJS4MMmX36Or0YU+YYU3nrZscrySH8wV4pg
	 xV7HTzrZPrto2e7EjabaBG7PHH9bz78Vdhfv/+q2kNzE11Yy6Gzq4Pwo2YkmKA4Ud3JbD
	 OBZoEwee6Kaa2XG2gLFxDXs4Gt3CO7y/6BsJw9IAPRJI3BoPcloGZSYIeFwqHe3BEmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KCmwAi76omzV3Ocey3RKQm8GgxKEzZYW/hAI8TU8mC4=;
	b=3P72ItuxCbaahp4hB1QD/rYmr9RAGMAMbD8YG5bx6ya0y8UjihRC7PPKCAQ5wsmEJU8u
	 26CqH3v2KiYZWPX3dXexVQsHoln7ZmOtGA7GEPR4onZe4MkCY5YSfoK/N98qfxfnnTyAS
	 FuBgL02Bd4tkpZ0D1yypVXOdqeyMF8Lp3pocQGngPe1tZwBzuYwrZ4be9ZBMFNpieOL5T
	 STQcdApYUbXsL+45sxRqer8HXsTWs4s6XimDokkhxROMf2muNyMn6duZlAr8TAqD+jaaB
	 ye8hjfX5GfnCcVNPcsmTPy9gUpung7yh77CyR9b1SoCcUar8J29HJz/3vU9ZTlrBNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUfJKR5C;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024560A6F59
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Nov 2026 01:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5024560A6F59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUfJKR5C
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53dda625f63so913209b6e.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795223481; x=1795828281; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCmwAi76omzV3Ocey3RKQm8GgxKEzZYW/hAI8TU8mC4=;
        b=dUfJKR5Co0HiNlns/knQqGqHSozCwHpvG5LIOoYKAgJKRpenRopNjyZmK7xCG8ERwI
         PAq8bVsgzkkPG5MVyhXwwDoN7ZQbWdpVXDJ7cma16N9BXU3PrItES3SfQxltxJP+/Jst
         VPVVOGNyn65VuPFRqCxZFpZD5WgkQq9fYBl4u62jzRDBwepvZnZhblOMUvtvHb6HWerz
         PlkBNvrwYx/g4+RTAP1dZJJBKa6iuV1y2ZTkLbZXhDnQMZSejcX7QlT7ZFq1gTIOJ1jz
         uVCUn9NwDEeca3HSQSQtc5I7WgJTnNJExQ12q3cmFRd9jAmo+MMv84Q0BpezbzLN6Vjs
         jVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223481; x=1795828281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCmwAi76omzV3Ocey3RKQm8GgxKEzZYW/hAI8TU8mC4=;
        b=EhrS4FedYaPbpFZYOT7xnZ4rTDgIIIxIHN2VdXwlEhb5I/sg/gAFwYoHRjWbppa8Ym
         F83LMKPer2w+XW/KbWQytEnBOpItBIj+u/Sx4xiEhX4nLBfWemwllMGd37Nq7aNYX+56
         +XmFmvJ+awZtNoms/NEtZ3+xauofu7sJUAVJFKDGEdvoUX9PIm6P0osRIDwl1S9wZk5n
         UmMF3v2sLan9XBna4r19ihTsuJ+BpM+wCyDyZGbDEJnJSGFLEKBAomcCy47FXdvX77l2
         fW9EfbBDuje3B/CL+dKQ+61/lO//UzMGMZER6tIxwC6JEbUqkFTR85G8asHwIwqDPza9
         n//w==
X-Forwarded-Encrypted: i=1; AL+hErEqaYVb1HJ+Z8n3HVdwxq3BjN164MinxlwiDSpLzqT5ZS+jYiAF4pHV9Ez/D6L96EFU+65Zo3PZVsrnvsJr1Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7mbH6hZ/ED0Qwhz2zt2rxf4B2MooGr+VL1GyZ0C7KMYzb9ePG
	uIkhoEi5K1ucHDzwbkZGNnxAk+0CbUucd8EMlxqXVRUL7zPrUurKAVC+
X-Gm-Gg: AYBFou05KImvBGOlHDRQratepXnlEzGwbYlqZgR6bJSL9gJXzf625Ksdesqz8R2nbbX
	pT+OpSIMW/b4/9F6GNxd0l/gGtfg1CZgMEAAKrCn9qUl6c5FMHJJiyLMGp/1/ZkggO/M1HoI0l9
	kZT6cSQNYFosuyrseJzEvc1PWlnVel6bxc137/y94yy/hPly0EyNxarLlmygqI74elZP8RpR42b
	oJQhwVRzA3U4VegG/yVlBxPMKy9Hi5O95wJzmVJs6N/1H45aGuN+JUBU9NznJW2BLWC6gVAonqP
	NrPkNJqMhrxEFbqMXqqTiFan/pJMDns8LfDuVL0twKrrVOj/joojJSf2Y2eNt0t8o4cRd0GSn6q
	p2I/qTyeAUqO32J50TpvvuWu8C7eugfZPbvFYASyH3kr48kNfiN7T9dOOg9MzBMAAHomOMvxFyj
	dRJIQI0D/4iMFS/U+0jrLRIWlGMwJsFKCanCosrIJBRjQCt5pxQ83qTZt/kwCUenm1Y0jMdakk4
	B0ixQxp3+YAChDnaBH7y3/7P1+QUNIcvX0mDxjr28OR/ktwrnwN2q7DRy+A79fnH4I32X1kHma5
	WlGJONPM9/W+rynAKSFjh9vecKwE7VlHbUiofR2NSYYWyMlzdp5q9NzkjF1PPNkfDmWFDcK6VyX
	esFud/qeGMxkyBG1lgGC7uuss10FWyZKGWAoGracc0v25U+8WFGo0VCKFcK6Pjo81vpFLkL98hr
	I00eq056zh4bt7v4uXW0/Cmt+TuHEDcQ3Pl6B3wOoNPycivORtDZU1OlhTbItwmIg8i1qvRTfne
	A==
X-Received: by 2002:a05:6808:152b:b0:53c:156b:a16d with SMTP id 5614622812f47-57a0a70b0d0mr5784172b6e.56.1795223481233;
        Fri, 20 Nov 2026 17:11:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm3291532b6e.9.2026.11.20.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:11:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 18:10:41 -0700
Subject: [PATCH v11 18/26] mtd: rawnand: sunxi: send all address cycles in
 split operations
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-18-9721b1905ef4@gmail.com>
References: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-0-9721b1905ef4@gmail.com>
In-Reply-To: <20261120-submit-sunxi-nand-vendor-oob-layout-v1-v11-0-9721b1905ef4@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.17-dev

When an address instruction exceeds the controller's eight-cycle limit,
the driver can report success without sending all of the requested
address. The parser splits the instruction; nand_subop_get_num_addr_cyc()
returns a count for the current part, but the driver treats it as an end
offset in the original instruction.

For example, an instruction with ten address cycles is accepted by the
parser and split into eight cycles followed by two. The second
suboperation starts at offset eight, so the old loop sends no address
at all while reporting success.

Use the returned count as the loop bound and retain the start offset only
when indexing the original address buffer. The parser limits each
suboperation to the eight cycles supported by the address registers.

Fixes: df5057999f8c ("mtd: rawnand: sunxi: Migrate to ->exec_op()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f8bc6e3c3ac9..ee68ef9bba33 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2410,7 +2410,7 @@ static int sunxi_nfc_exec_subop(struct nand_chip *nand,
 		case NAND_OP_ADDR_INSTR:
 			remaining = nand_subop_get_num_addr_cyc(subop, i);
 			start = nand_subop_get_addr_start_off(subop, i);
-			for (j = 0; j < 8 && j + start < remaining; j++) {
+			for (j = 0; j < remaining; j++) {
 				u32 addr = instr->ctx.addr.addrs[j + start];
 
 				addrs[j / 4] |= addr << (j % 4) * 8;

-- 
2.53.0

