Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904963;
	b=cT7DkwLrMNmXbogHIkYBc/iNIEEKUCV9sUEnSMTbS8GR9lMVdl+lVQP30YRDTmihAe5f
	 5A2ylwl+WsTpchRY0VhqcsUOIAyMS+75mG0/POfgmiWwh4K1DODWuajZGqXSv+KeZMrmG
	 z6BaLakZIKgK52wtGmo56dnCHWAl34Cerhcmgt9h3XsB9n6YI+7Gs8S5bNd1dI3tnh9+/
	 St0SL1xjrNQ0vU8137blO6kiBXyogkv6vEb6F4mAg3rVqQGOt9ceOts6jOwmXUomZgskf
	 nEgmpGPDIU0qY4D2ajBefFQ+44lMQbT0hgedMhC9TA0h/fqBWtEoDj47VjzTTriY3Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=fuAnLXLxkTRIWi+f3sZBwdM4q2MUL37Wpqf++mUfWMk=;
	b=Lh1zYT5LSn0XnwCId41DxzDjbQFc0K6jyREvNvw+KCdI+QNmnQWs6WIKhDmMiVjqn64e
	 jx6f28GGgtHvJswSVBFB2VZw6FQYnjm9j1/M7V9Uhin/o61kUKhV16AtVHVId31PDAjnA
	 5JWLsaEtvwWMq1kKLJsJn8TS6ICcvVKXlLpVjFPeybNbj/xrFWa7BsJ5qxGxiWXNbi22s
	 3SSCAcJMufgpT4tHnHbAf+DurXrasRCqrQHehUcHbqE4aWzY+ekAYqZy/FKUUyUt6xR9b
	 ZNAQr4o6Yo09dpYGwLFB/ls2bpY7bnqh0WXpuvwjAU1WvAmlGNloyCuYAc67l/IfbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2EjzxmN;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9C606A33C
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD9C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2EjzxmN
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1521724eaf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904962; x=1794509762; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fuAnLXLxkTRIWi+f3sZBwdM4q2MUL37Wpqf++mUfWMk=;
        b=i2EjzxmNhmlyLorG7VwLdqDMz5uk2LAnTwkEQu514gNAH6I5/dyrXBOSCIpXROByIw
         s6NJCgB7zkDh0ntj0JvhQ03tv4R0zZRsxNg8tdvnO4dAL8NC8+VGKwy8NV1O2xGMwogR
         SRwFuE9v0i4ApPLNyWcrzsUmS6bai4MOfLVOn9xrLlzVU4QBTe27cXmiHOmG0as/3Dd1
         RH3Da5v2c83tELiKbO0zwHvwBiiNnD7OYuDf0sEtopvLZ8sSK1dQfGfnqgyJY0SoNvpM
         B+dve21J7/OtBTqooJIqWpqZ+mbApsXB5C3XPZPUD+8A434VF/z/b3jOKfeetlcUVg61
         b2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904962; x=1794509762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuAnLXLxkTRIWi+f3sZBwdM4q2MUL37Wpqf++mUfWMk=;
        b=00+WpSnY8ZcTAyy9PpjfVmq3ad+IyFqNvNQjq4OLkjEVMqOtX9LndQcXxU1oySpoSl
         DLsbCjHKK9vx6A7+CMxKTpyAguE8IN8wtlOIrmuEu+wwiDrFbA1wZsQf5SHTj2hVcVxq
         0sbjrRtJtILKkBy8MArfHLUAHF//4kbw3PGa8f/IfFmnOdvSl/iWq4XPqt5a1c2BQld7
         7/mnNiKQyU9ltOz8ZOZoOpwPWvPJS664aUGy6afhb3dNm5SUhgM91ug9TPsmMaNX08+C
         yy6E3r+6UL2oiM+gkACI1qto09go+05LXuUvg9c0VjLvWdbjva3sZxqQv8prgWltBg9E
         vsCw==
X-Forwarded-Encrypted: i=1; AKwUvBzMTmTeh337JdbR9+62rIgMtUfwmqpBwA4R1Vy9oVjbf4kBEuBd6D1APqHGwChrWDsaSkJON5Ms4lBmKcuMng==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TKoN1ceY/2WlzA5TWa8gAm4yGUr49cMJHwKXgs9mk46AswEw/
	N2Oeo8sGm4Ly4BOP0uIticETF6IHlApM3JY2o6YYknR9jCU0SdtfcCPt
X-Gm-Gg: AYBFou3aX1PhezvR+TZCnumnWuKd5IS2ziEBgW8RGLIQu/amuFyGd+e2kkblPeLbJGr
	kOrdvLN7sVz7C5pPBZZYyBAnlS+8RsnxplCz2X6Tbl1HccP+wwstraQzWsBl6TGM33hyq4AahNY
	y6PC9k9yprbAzCpfvBwOHH7XdMQAY/XmRL+HJs3mxcLL3p31l4lK79GTfKUB3tAkcAMZA1lCXeT
	nv+UDa/fca7Vcm23Ly0rLnodRw9aWUhjS7eklcgjQbpVw511V6mAky66gs5KsfoaBgEhRd90ij3
	gwSc9ITZaLXpo/2umQeaz7CjRzgYxkp3UfWfsrK5zbH7yNiqY+ZqkEJeoLkyxxqL88QuFL5ApGE
	YDfUPDtJDXBZ+wzojyykTwQD3MMov3Es1U/+mSAsx35KWutMD6K83wWnEb9vcWsf1E1hUsk2bH+
	shw5fVkxobsQ/ygEuWBqPyGMkAkFFZbEhTrKtW6iA0eaIDX6XOMgfArlUaCyJ2xBkOLYeMBH/qG
	VgCNN0yK21mdsUKU5g7AmkcUEMBPAFULm65coSwe9uticAoBE1v3Zn5FiV28pjtq4pIod+nXAOI
	G24odRh7Wv1AAD3cdOFz9GWTz+9sus+9w3EYIEIR0J2izMa/hFhNEdKzDiY8LO2DRbbHNk8aDmi
	JcOADr56I+dNIT8cHJqsBI+BbFwlL6J4vDtq20xzfnUmn+jeTjA/b9iABv7DFgb/bUHnjPwpFzE
	oH2oH9c0cZfL/E2kHnwYga4NnxkNO3F6LQkP7RRE/XQVKHyBAxcS6k
X-Received: by 2002:a05:6820:c91:b0:706:50ad:fd7f with SMTP id 006d021491bc7-716e7b33226mr291273eaf.87.1793904962431;
        Thu, 05 Nov 2026 10:56:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm115897eaf.0.2026.11.05.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:56:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 11:55:36 -0700
Subject: [PATCH v10 20/26] dt-bindings: mtd: sunxi: require the H616 AHB
 reset
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
Message-Id: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-20-dca1f6ed29a8@gmail.com>
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

The H616 NAND controller needs its AHB reset to stop internal DMA and
restore data ordering after an aborted transfer. The controller's soft
reset alone can leave the next read displaced.

Require resets and reset-names for the H616 compatible so the binding
describes the reset needed for recovery. The existing H616 SoC description
already provides the named AHB reset.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 9d061e2216cb..ccf616fabc91 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -119,6 +119,9 @@ allOf:
           minItems: 4
         clock-names:
           minItems: 4
+      required:
+        - resets
+        - reset-names
 
 examples:
   - |

-- 
2.53.0

