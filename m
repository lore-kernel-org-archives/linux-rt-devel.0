Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595A447256;
	Sun, 18 Oct 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327413; cv=none; b=sNIQaX8LyBjqAVW/Usobld4QPCVabWmDiug04kVXTvb7CULTxxEXRmg0wR5YGqBJMwAOMBpF8pAxWKu9wI8Kg03ZMYnz4cpJ8ZQdizeE7QiMOyFBD1fxlC8KRKcxwN5rc5dzDMUfIsHYU974MAua/46Aqn4Pxnzn0j/M+6E4LYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327413; c=relaxed/simple;
	bh=ayUEIw5CC/Oo9JP2AH2EBFZlXFxX08FMa3VuTPOlLsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maqKigUUGbfC/zZByJnMpZ9rbbmPogH97oUmjBP1Y0swTXYfOLiVaK6pI6hnLfeEKxhxT1nSnV+pOAEH7BW+2EbNtQRlGdkvsqwAN3YvGMN1xxT20K31ImPsfPkQqMstz/bgCa6FX5nLjikVYf3I+z5sIIqujYeJu6e6YOMkcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bA/dyefO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bA/dyefO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WMNkipMcwPMTP7cNA2CPWIUSwQ0qxyWJjxciMxCkqng=;
	b=bA/dyefOAdLU4Vyq/EAH0tER0OuFcZuUW6gEJyj8Po6nRZkJ1R4dtcDNE97wm2
	5k7Wgvt9xX08Vl6ucS+gSoX5V5idtKURK524ymH6p+UGIIMgM9GET/ZsLhJMr1WL
	ZhI/DveznijksLSFKrnkRhAdqMhC4tlyet7QPg5vMi+QE=
Received: from [IPV6:2409:8a62:3e8:8320:6021:18bb:3ec8:2069] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD338SqvtRqvbUHBA--.4070S2;
	Sun, 18 Oct 2026 20:42:20 +0800 (CST)
Message-ID: <202f3cb0-a599-44e4-8048-8cbe22b9eaa2@163.com>
Date: Sun, 18 Oct 2026 20:42:18 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] pinctrl: stm32: fix hwspinlock timeout and EXTI
 mux locking
To: Linus Walleij <linusw@kernel.org>
Cc: antonio.borneo@foss.st.com, bigeasy@linutronix.de,
 alexandre.torgue@foss.st.com, arnd@arndb.de, clrkwllms@kernel.org,
 lee@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, mfd@lists.linux.dev, rostedt@goodmis.org,
 u.kleine-koenig@pengutronix.de
References: <20261014160917.139241-2-junan76@163.com>
 <CAD++jLk9Rga0OuaKyojE2ViT9cBcmD_Ow-pMth-qJbTfHgcybA@mail.gmail.com>
Content-Language: en-US
From: Ju Nan <junan76@163.com>
In-Reply-To: <CAD++jLk9Rga0OuaKyojE2ViT9cBcmD_Ow-pMth-qJbTfHgcybA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338SqvtRqvbUHBA--.4070S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr43Zw4xCF1UGw15GFyfJFb_yoWDWFc_ua
	ykZa4kCw45Z3W7Ja12yr12kFyS9FZ7tryUJ395W3ZFvr9IvrZrZa95GrZ7tF4Fya95A3Wf
	Jr9aqryIv342kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRdWFUUUUUU==
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9QyqXGrUvqzLgwAA3r



On 10/16/26 9:19 PM, Linus Walleij wrote:
> Hi Ju,
> 
> On Wed, Oct 14, 2026 at 6:10 PM Ju Nan <junan76@163.com> wrote:
> 
>> This series fixes two problems around the hwspinlock-protected EXTI mux
>> and pin configuration accesses in the STM32 pinctrl driver.
> 
> Patches applied for v7.4.
> 
> There are still complaints from Sashiko, but Sashiko always
> complains so I'd say at this point we are close to the merge
> window so it is better to follow up with separate fixes
> if there are more issues.
> 

Thank you for applying the series.

Many thanks also to Antonio and Sebastian for taking the time to
review the patches; your feedback helped improve the series a lot.

> As maintainer I kind of have to decide whether to wait for
> the perfect patch or if perfect is the enemy of good and
> just merge the patch so the baseline looks better, so I
> decided for the latter here.
> 
> Yours,
> Linus Walleij

I've looked through the remaining Sashiko comments. I'll keep an
eye on it and send fixes if anything comes up.

Yours,
Ju Nan

