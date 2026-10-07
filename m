Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3F3016FB
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Oct 2026 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334630; cv=none; b=iw+Wp8f9eoMA87PE4zNg6fE3SBAevxef8KZa8SPsK5x7ie0drwrTc9e3zgYuOtvzzFZY7DvZ4FhAfS3fOyajNLGqd1iYFx5MdvmU8R4ruEnb5G7guFCGiWUXgKfPii2YmN86MGidUcIT6hwZyxxHXxIpCAYwXHYMMHYS7bhpWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334630; c=relaxed/simple;
	bh=7qihWULzhNXrMFY/3lzqq7H5HpmEEjJl5mAZAg5n+k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS3EJk4Ecq0epJJN9DuDFw1OzeAE8Fa79lSLhXthYuXpc/etY7PXCeuKFG0cexvl/zT9vgujKImxb4E22kWqC8qQWYi5L6ITfeq6C3aw/XePICaoO7/QOJOQ1XsF5WlhWig2JYLG8xDQR2LtlEohYIjZuAN8lAX7VXuQhWbyMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBfy3o2n; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBfy3o2n"
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8216bf5eb5eso1685310a34.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Oct 2026 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791334627; x=1791939427; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAIWhhMv3PYHKISI/ix1jVDueQPVFVtzNluL37GORz0=;
        b=MBfy3o2nU+tVcsNjIHsTt6ua/d3/OzVPgmAdYmyBm0X6Mch1IIq3mUDvl9H2KYu6v5
         evHiXYwasRBbzDTjqSL1lqMX1cV/iH/1sGG/yEx/j1Ojsi4De0OfHr+xYhK9ovFCYRrl
         m9EA/XLXOfBemjCRgY68CmIrrV3bOw0H8jCEJkGIiHHAPxMULRl7+w82JzD5++XNsaQg
         2ZHzLpNGl53vmn2uhBHSTdV3oulXQRMZeT4NIJzLVcK7XrjV5f5yI/gOawB54kct87yl
         IdhEZQHTg7pl2oPdu+YN13xWyoQXZ66DhJz+GRf+wkgkvG2ApqjjVl1u+ghhsyt8bGQj
         xhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791334627; x=1791939427;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAIWhhMv3PYHKISI/ix1jVDueQPVFVtzNluL37GORz0=;
        b=SnYZr8yOwjYNLp9d8vWS31e7M4qeKaidTMstbbqPFW+dXgYmHdgvmXNUumETllJjeI
         coy6zhneF9rpuJTCr0aUAmNj9bQ/khObvks/R6d8Q8HtS0OgstexaArxChD9xu4dlQSN
         veWvbvYZdDVcv6AhCrE8y+iAxVGsIt26UbIXf8utEu2B3mBRGmYf1ngx4qXsCQ7XXgoP
         B9VyTI3a+52/NNPJTQnmeY6TrEDn9qEdiuPJE92msYL7u+Lv2xuDSZc8cDEhCovZYiFJ
         iiE1La5QlaMUXePI5QsIW1bW+tdkbUCdJb2RCwG9eUsztBNyU+MGw6azvb5Quwp71OsN
         akwg==
X-Forwarded-Encrypted: i=1; AKwUvBwSH+kBwqSldQbiu4SqSwcz3NTVA8CA/cdz4kv0VvUYZIhhaoXyT4GiPPQ1oBGbfI/R2fTKV7VR9CNePLdzRg==@lists.linux.dev
X-Gm-Message-State: AFuF++mwpYq2C0JD6R4s+XntlZMhYAstEAgl/mP0XZoZhRsEtzJqikm1
	B6s7HvLDB5yQ45XDK0m+6Vf9Eup0QjFfiMPY7TB8i9K7wKuBnqNH8/Oz
X-Gm-Gg: AYBFou0/47AYlFIYZ6oI7wRwEFMUXi1+AGVbApJCYnsVAk3BY1uhnWLkfRuLJ9UPUlO
	x+ik+zQLdCEFVQcEzCfy+K0IP038jxX4mAO+vvBcv/lNmMbS3xRaLrRp0BmhND3/cMKh7r5mFTu
	5SDE0ymAF6zayr3adyYQtfif2sWqEv1E18Rv2NLGSPysDqFb9TsfYSeLJxP9KT3nV1zdS2fT3q8
	r/i11D8/NX7smB318VS6oRIqhqUOBiA9Cob62X2wfR4IK5FpFrk8gJQcgdfGdCRcSpDTIO6dOWP
	6OWyUedtooOA/Td0LDLP51p/ATxusA2wzNkjNhRw+VSUNMLmwGvWute74BkRJLvH9T41mZhO2QG
	c4EnZ+ukTEnMewrzgEcOzqq2+8NyBvosFSu3WjMk7JgF4GObgLwfmgpHEXnCS6qliM+mYSOhnPA
	cRAF61dkpT2CSsWSBoZijp45eKLl0JIjQpbb0VYCCnuJoyXOcFf1ge0e/cwEKjiZRnDz7PgovS5
	bAjrgkzwXtKfXASQ/4SQ0S7u7uVWNwKmbaydrfiIiB9cqixXyxh
X-Received: by 2002:a4a:e90d:0:b0:6dc:e1c3:b2d5 with SMTP id 006d021491bc7-6e7a913602amr915341eaf.75.1791334627605;
        Tue, 06 Oct 2026 17:57:07 -0700 (PDT)
Received: from ?IPV6:2600:100b:b034:8212:4cd5:c80f:ba72:80cb? ([2600:100b:b034:8212:4cd5:c80f:ba72:80cb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a25722e3d8sm1005183fac.15.2026.10.06.17.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 17:57:04 -0700 (PDT)
Message-ID: <d3d3e7b3-eb8b-456d-9a2c-116334e86c14@gmail.com>
Date: Tue, 6 Oct 2026 19:57:01 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: mediatek: common-v1: Use a raw spinlock for the
 pinctrl regmap
To: Chen-Yu Tsai <wenst@chromium.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Sean Wang <sean.wang@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Hongzhou Yang <hongzhou.yang@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, mfd@lists.linux.dev
References: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
 <20260930080609.dnK1-Uta@linutronix.de>
 <CAGXv+5FssQL3Go3VDFbLAT6HP12RS3U3OgxhYOeapzs64QTdUw@mail.gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <CAGXv+5FssQL3Go3VDFbLAT6HP12RS3U3OgxhYOeapzs64QTdUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chen-Yu and Sebastian,

Thanks for looking at this.

On 9/30/26 3:17 AM, Chen-Yu Tsai wrote:
> The syscon node is the provider of the regmap. You need to fix it there,
> not duplicate it in the consumer.

Unless I'm misunderstanding, no driver binds to that node, so its regmap 
comes from the generic syscon code, and changing it there would affect 
every syscon. Lee, Arnd, Mark, would that be acceptable?

These are the options I see. Please let me know if there's a better one:

- Do what Sebastian suggested and make syscon use a raw spinlock, except 
when the node has a clock, since regmap-mmio calls clk_enable() under 
the lock. Off PREEMPT_RT, nothing changes. On RT the lock would no 
longer be preemptible for most syscons, including across bulk writes. 
Most syscon users that do bulk writes only write a few registers, but 
enabling the Amlogic G12A PCIe PLL writes a sequence with 40 us of 
udelay() under the lock.
- Have the pinctrl ioremap() the node a second time alongside syscon's 
mapping and read the input register (DIN) with readl(). That read is the 
only access the EINT code makes in raw context. This would go around the 
syscon, and it requires that DIN never be written in a multi-step 
sequence, which is currently the case.

I'd like to know the best approach before sending out a v2.

Best regards,
Ryan Brue
