Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904953;
	b=w2gfm4i+OTcRorn1LrBpRnxJ+SBjbiT1g+D5cr8kerF+TRNQ+qc/cbMbsOAZrWCvINk9
	 1bWUvLBvKhC2N9qDR+s1xHzLGKl01jqf/RPCBzeJ/Gcn8MvKmqmV5ClLraSll3KZBQ1u+
	 gixFrabm7yjLy8Gd4Dink9cqLEjPuqvJw6xnzfVA74/+qSgAHOXX01e16olMiD2d/AZPX
	 abDp/ZIfcNBEnvfxj91kCZ7WqZzakBGtx7R2xLhoDheXdTOph22XUqfJTfuUbfq+L4lYB
	 nhpoO/khoQ/rrWumqC11cFee6q+SsQtdWxOigv/7M6hqc15vojItp4xQKLF8xQ7N29w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9vgROzYjn2zK6ttGrhZKySS2hmoJVCYg6HGqDUPiUOs=;
	b=xODaYhVnlEU0XC02z09YXJRcD8aHHwNkVESj5CaSD/6LmHK0a+nmLHr8spZrYm6kBQHA
	 gkT21m8AIcmKErp0TN7W02M8FOqvjbVgxHEGnml5nOfWez8jgVWG2hRSYIaTeAZ/0cwTG
	 9QMZYEyVxkTGyE2OZgrj4ef9Do/RsCeQzffpxot8Ag7az0E5I+o45P2RRUWlMVoUgIUu2
	 4qKjBR/qZ/61tqtWtOOmNgG9QrQ9X/ImlUcXWN/Rof2PnBgeZ1BrfVBYh3jht1+9UnAVu
	 hKg9T6tKuno/lkHOdrMolFOPgU7E79OLGGppkmRk+7N7pexVB1nhGy5kpzxRIi9svSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PgAYxEsY;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BE606EEB4
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132BE606EEB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PgAYxEsY
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-702dedeb70dso1295933eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904952; x=1794509752; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9vgROzYjn2zK6ttGrhZKySS2hmoJVCYg6HGqDUPiUOs=;
        b=PgAYxEsY5Bct9+wGOMlt0Pvut5S4ufy/lPmP9te5amLdODBz0PzB6Jy9A04ARnvr2p
         Tq/TelkJgWWL0XFGxhRznJkXis/NVUbDE60XrVKCsQ6cNueFCHP1YuBXs4yyxMztRULT
         sJlp+sjZ1HRAGWkjZfNoevNOKXGdBnnGTfXmlYqnsx/p50Y24NNpCT1A5UoK5KTh7zIz
         GUQJmOEh0wB6Nk2QGQcE8VBI29DrCBalMwr0l0BzvpD4zBmxNXAKeWP3sVUfGyeFZSeq
         eumzZJEgsg1WlifNgDC/q0dl22CIeuKXIKQwpjpmpVv7F4aKH8xXqUDtHBNveF/pVOV4
         WktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904952; x=1794509752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vgROzYjn2zK6ttGrhZKySS2hmoJVCYg6HGqDUPiUOs=;
        b=zAi3b3LC6h0YDy2hKwsa+Svwb5LN9kHnI0XwABRLOYCFw0NPk21yDLlxY/AItd/ea7
         DDKFiYPPA5nQBI2QlctQXN6odRzZ4324oXFMjslsL33FGkojLUmN6qu3tSrryuNa6Vha
         yCASEMlyrfFBMEi+4UPnWr1ZCTlmCjp76IOTfmbXzmnYRLpwCXEtqQtaA6169anppOjG
         GbwYQM4qDakiHFye+aXDsPFyrbBW2tSF7L8S+mHrvpeiRoIl65nuf3KiyD0cI2KmIAAJ
         7JZy47jwxbseqq/CevOCZlWGfbyUzHId2HRlVPVewN06ZqkU0sLOYBIHHShKxVirD4r+
         76OA==
X-Forwarded-Encrypted: i=1; AKwUvByip1H0dg/7Kbh4fl1LH5GLaOaadUu77zhYgKmzB2pmlE4rGAfa9FpNcwfBXbm/vT3bkPM/5TZa3ZDGNSrRow==@lists.linux.dev
X-Gm-Message-State: APuU4Z822aIBSOmFU4qTszv7Luo2jaZl76DnBvJRuSG1NgLGHp6mPRcg
	BBC5+sPI+p3ZJ/t+hGOG5a7gLZEGccCE4/TSZpmQCqNnvXgkBZmeDKB8
X-Gm-Gg: AYBFou0KhEoJvq4LKgDMZxGn+C1boLV/Gvtm4MYo8tcrGeEYlJNT+jcEYl+wBx9AJ8V
	WaqGVHK8Ap/AY0h4DvuCsZSPTm02vdE+6P+o1EEuTDhK4VmawP6DYFgZCFtVckwzsxpwSqSOHxp
	7WuqOulQnuHWcMwGdf4LQV22rb+5we+D4QormlFtgSZs8ZEEuzFzTzrUjlutjPj1yBuTvZL7i21
	qyRVoLtQFBkNMLEaTuzArEYiCykyKmC82D5XMS2D3gefKujhKIDQTuFcMQrDMwT2ds/ptJwYBiF
	czLl6lazMvA0qd7/vW+cLMT46jjZ++kyYEaUBejrDNCtrJzvOBDxy5HovM9qdCKpXSa0uASrRKo
	4wiEl7lyyw7N0Wp7wbpo6VrSfUJwvge/JG13L0Bnh9r3Oslorg3o/mmQDbbTakspJW6apmBAao6
	QMT1LRG02wN4jRqKzQM0SI45dlw+55YecNzkB0Ks2QQQ+kdRLSbCVWVUgkyPW8PJVZqSEk3y96u
	zRC2ULplYlsLNtf0hEzLMjOdwbgRzfFi47I3d1iYXPyLcGarQjJCoLKIRmprQxLPM6qi2p1VDKp
	MJ+/DBimYANmHIsHWJ1YRvREoHREeNJX+qR8jePPQStZX++gDMQLDvCD+/dT7qHmGABsrWrm406
	qFd5zK1H4GgUPlcWpesro4CAplHL2NLdE59m55yeOXPta5J+6pf4NxCEFcvN4sK9uHhyZ0xSrZI
	cxV26Ik5AfgXNklaR1JHlkzsJKlds6/Amm/e2oWCRduvRKd9RPxqoKMg==
X-Received: by 2002:a05:6820:c30b:b0:716:deda:97a4 with SMTP id 006d021491bc7-716e790f945mr252144eaf.48.1793904951958;
        Thu, 05 Nov 2026 10:55:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:55:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:28 -0700
Subject: [PATCH v10 12/26] mtd: rawnand: sunxi: avoid a second program
 confirm for OOB writes
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-12-dca1f6ed29a8@gmail.com>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
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
X-Mailer: b4 0.15.2

The hardware-ECC OOB writer fills the main-data buffer with 0xff and
calls the selected page writer to program it together with the requested
OOB. Both the PIO and DMA page writers already finish with
nand_prog_page_end_op(), which sends PAGEPROG, waits and checks NAND
status. The OOB wrapper then calls that helper again, sending a second
program confirm without another setup or data transfer. A failure of
that extra command is returned even though the actual write has already
succeeded.

Return the page writer's result directly. It remains responsible for the
single program confirm and status check, including on the
bad-block-marker write path. Raw OOB writes use separate callbacks and
are unchanged.

Fixes: 25f815f66a14 ("mtd: nand: force drivers to explicitly send READ/PROG commands")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f003da59cbe7..5f57c5998f03 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1841,15 +1841,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	u8 *buf = nand_get_data_buf(nand);
-	int ret;
 
 	memset(buf, 0xff, mtd->writesize);
-	ret = nand->ecc.write_page(nand, buf, 1, page);
-	if (ret)
-		return ret;
 
-	/* Send command to program the OOB data */
-	return nand_prog_page_end_op(nand);
+	return nand->ecc.write_page(nand, buf, 1, page);
 }
 
 static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {

-- 
2.53.0

