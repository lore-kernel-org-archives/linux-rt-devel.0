Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DC43DEDA
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149416; cv=none; b=FbK4w+GSdnlEGGxxVG8aGe/fesUlO/pfN6m7OS5z/lrF4XwYWWNlQHpiUKExNCZMCmiLpMgKg8uAaa5wwFMVTvAABDvwP1LpczkSymPC8Pky8+sWt0c4egTSyuKbZS3/7Mj3JudbuHXOg10d/BddbJTUFjPkphlVstmWt930sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149416; c=relaxed/simple;
	bh=i6fwpuUOpMIA6VXs9SAe7csVZoeWuMIseGZ5kYMEh3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYK8Xjb6YDKNcydQhdv7kbD7kM7MN4J1Frr8OFkjTOXtVTAbCYJPCfSSuLUoPewTepOtON9fRErahYC90Tsauhd74nlX4oyec4avqPoxXu3e5p6mf9CaU4Lme+b7qaR/xhV8ru0YgJGQ4u+IQ88ZSXZjhLHrDN8XhCOLFZVPvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VWpuoivE; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VWpuoivE"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ed879dc4;
	Wed, 23 Sep 2026 15:43:23 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from hardirq readers
Date: Wed, 23 Sep 2026 15:43:16 +0800
Message-Id: <20260923074316.2929892-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923062454.0W45uc5U@linutronix.de>
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn> <20260923062454.0W45uc5U@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cd38250603a1kunmb397eec2c4e15
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUsaVk9OGh5CGRgYGklDQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=VWpuoivEuWZYFPGfP69znu4el5xWvnRAvesS60OEl1o5bRR8y9TbIHxSZfUW7s8TX26kmkl2XWoF1mUlHm8qrMD3CAxgNPYNuRra5CDtMfJ8I7SBWft09xvkKFrHaooYHh6DSOonw0Nd4ljwG/UmIAP3J4EcWwGwmZY093gqQbo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=i6fwpuUOpMIA6VXs9SAe7csVZoeWuMIseGZ5kYMEh3A=;
	h=date:mime-version:subject:message-id:from;

Hi Sebastian,

Thanks for the detailed review.

You are right. I rechecked the in-tree callers and confirmed that
gen_estimator_read() has no hardirq caller. The hardirq call in my test
harness was an artificial caller that is not part of a reachable mainline
execution path, so it does not demonstrate a real bug.

The injected reader also overlooked that a hypothetical caller would first
hit est_fetch_counters() and stats_lock. In addition, replacing
preempt_disable_nested() with local_irq_save() would conflict with the
PREEMPT_RT rationale from 9f74c0ea9b26.

I will withdraw this patch and will not send a v2.

Regards,
Runyu
