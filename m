Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83715E96;
	Sun, 17 Nov 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822041; cv=none; b=besuT1lE85syfA6NuRm95875qtnlVKxqSkmT2rBNtKpugols6UTmmvXRUg3NsfJNXsDnOnf0d4sIfHnCD8Vge3dd9J/u7cVxI5wCDQwSnjsGDGP5MBknIvvZLflrCy4FFmK7UowP9wZPrX+LCana9jA+Lw49M0xdl6W0gKTUCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822041; c=relaxed/simple;
	bh=zhBhIEbH1gp3YvyAIPkxgVzsMDJ8x+9DQe3qhi5ssK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtD6T86RNevrtkqshrk39ufnLOndjBxa+uyoZwjwwESxCUxzNAEmSfar5EKSclkaLfQGnOmBrQSmclkoiIj4UnMKNg7aYN6UWN/9CQrbszK3SpTkuqvLswJe81LcQiL6M9QxA+asK5u9JnSxAFxRY4y8g337sdpQWpA6jzP4lbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8DxGeHVgTlnFwxAAA--.60624S3;
	Sun, 17 Nov 2024 13:40:37 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBxO+DDgTlnJ4NZAA--.10317S2;
	Sun, 17 Nov 2024 13:40:36 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: loongarch@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 1/4] LoongArch: Reduce min_delta for the arch clockevent device
Date: Sun, 17 Nov 2024 13:40:14 +0800
Message-ID: <20241117054017.3938700-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241117053740.3938646-1-chenhuacai@loongson.cn>
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxO+DDgTlnJ4NZAA--.10317S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFyxuF43urW7ArWfXF13Awc_yoWkJrc_ur
	17Gw1DWr9aqFZIy3ZFgw4rWw1UKw48tFya93ZrWF43Jw15Jr98GFWDXanxArn0qFWYyrs8
	Xr4jqr9akr13KosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
device. For a 100MHz hardware timer this means ~15us. This is a little
big, especially for PREEMPT_RT enabled kernels. So reduce it to 100 for
PREEMPT_RT kernel, and 1000 for others (we don't want too small values
to affect performance).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/time.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 46d7d40c87e3..a07d7eff4dc5 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -127,7 +127,11 @@ void sync_counter(void)
 int constant_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
-	unsigned long min_delta = 0x600;
+#ifdef CONFIG_PREEMPT_RT
+	unsigned long min_delta = 100;
+#else
+	unsigned long min_delta = 1000;
+#endif
 	unsigned long max_delta = (1UL << 48) - 1;
 	struct clock_event_device *cd;
 	static int irq = 0, timer_irq_installed = 0;
-- 
2.43.5

